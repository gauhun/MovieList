import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './movieRepo.dart';
import './movieModel.dart';

//--------------------EVENT
abstract class MovieEvent extends Equatable {}

class FetchMovieEvent extends MovieEvent {
  @override
  List<Object> get props => [];
}

//--------------------STATE
abstract class MovieState extends Equatable {}

class MovieInitialState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadedState extends MovieState {
  List<Results> results;
  MovieLoadedState(@required this.results);

  @override
  List<Object> get props => [results];
}

class MovieErrorState extends MovieState {
  String errMsg;
  MovieErrorState(@required this.errMsg);
  @override
  List<Object> get props => [errMsg];
}

//-----------------BLOC
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepo movieRepo;
  MovieBloc(this.movieRepo);

  @override
  MovieState get initialState => MovieInitialState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieEvent) {
      yield MovieInitialState();
      try {
        List<Results> movies = await movieRepo.getResults();
        yield MovieLoadedState(movies);
      } catch (e) {
        yield MovieErrorState(e.toString());
      }
    }
  }
}
