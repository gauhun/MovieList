import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './blocPattern/movieBloc.dart';
import './blocPattern/movieRepo.dart';
import './blocPattern/videoBloc.dart';
import './blocPattern/videoRepo.dart';
import 'package:movies_list/screens/home_screen.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies List',
      theme: ThemeData(
        accentColor: Colors.amber,
        primaryColor: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MovieBloc(MovieRepo()),
          ),
          BlocProvider(
            create: (context) => VideoBloc(VideoRepo()),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
