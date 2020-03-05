import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/blocPattern/movieBloc.dart';
import 'package:movies_list/blocPattern/movieRepo.dart';
import 'package:movies_list/screens/movie_details.dart';
import '../blocPattern/movieModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieBloc movieBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(FetchMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moives List'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitialState) {
            return _buildLoading();
          } else if (state is MovieLoadingState) {
            return _buildLoading();
          } else if (state is MovieLoadedState) {
            return _buildMovieList(state.results);
          } else if (state is MovieErrorState) {
            return _buildErrorUi(state.errMsg);
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }
}

Widget _buildLoading() {
  return Center(child: Text('Loading ...'));
}

Widget _buildErrorUi(String err) {
  return Center(
    child: Text('Something went wrong!'),
  );
}

Widget _buildMovieList(List<Results> results) {
  return ListView.builder(
    itemCount: results.length,
    itemBuilder: (context, index) {
      return InkWell(
        child: ListTile(
          leading: Container(
            height: 200,
            width: 100,
            child: Image.network(
                'https://image.tmdb.org/t/p/w500/${results[index].backdropPath}'),
          ),
          title: Text(results[index].title),
          subtitle: Text(results[index].title),
        ),
        onTap: () {
          navigateToDetailScreen(context, results[0]);
        },
      );
    },
  );
}

void navigateToDetailScreen(BuildContext context, Results results) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) {
        return MovieDetail(results);
      },
    ),
  );
}
