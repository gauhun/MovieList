import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './videoRepo.dart';
import './videoModel.dart';

//--------------------EVENT
abstract class VideoEvent extends Equatable {}

class FetchVideoEvent extends VideoEvent {
  String id;
  FetchVideoEvent(this.id);
  @override
  List<Object> get props => [id];
}

//--------------------STATE
abstract class VideoState extends Equatable {}

class VideoInitialState extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoLoadingState extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoLoadedState extends VideoState {
  List<Resultsv> results;
  VideoLoadedState(@required this.results);

  @override
  List<Object> get props => [results];
}

class VideoErrorState extends VideoState {
  String errMsg;
  VideoErrorState(@required this.errMsg);
  @override
  List<Object> get props => [errMsg];
}

//-----------------BLOC
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoRepo videoRepo;
  VideoBloc(this.videoRepo);

  @override
  VideoState get initialState => VideoInitialState();

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is FetchVideoEvent) {
      yield VideoInitialState();
      try {
        List<Resultsv> Videos = await VideoRepo.getResults(event.id);
        yield VideoLoadedState(Videos);
      } catch (e) {
        yield VideoErrorState(e.toString());
      }
    }
  }
}
