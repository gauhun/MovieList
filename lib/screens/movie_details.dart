import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/blocPattern/videoBloc.dart';
import 'package:movies_list/blocPattern/videoRepo.dart';
import '../blocPattern/videoModel.dart';
import '../blocPattern/movieModel.dart';

class MovieDetail extends StatelessWidget {
  Results results;
  MovieDetail(this.results);
  VideoBloc videoBloc = VideoBloc(VideoRepo());

  @override
  Widget build(BuildContext context) {
    videoBloc.add(FetchVideoEvent(results.id.toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies Details'),
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        bloc: videoBloc,
        builder: (context, state) {
          if (state is VideoInitialState) {
            return _buildLoading();
          } else if (state is VideoLoadingState) {
            return _buildLoading();
          } else if (state is VideoLoadedState) {
            return _buildMovieDetailBody(state.results[0], results);
          } else if (state is VideoErrorState) {
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
    child: Text(err),
  );
}

Widget _buildMovieDetailBody(Resultsv resultv, Results result) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Center(
      child: Container(
        height: 320,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Scrollable Content',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${result.backdropPath}'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  resultv.name,
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Site : ${resultv.site}',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Quality : ${resultv.size}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
