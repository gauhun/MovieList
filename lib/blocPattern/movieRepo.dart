import 'package:http/http.dart' as http;
import 'dart:convert';

import './movieModel.dart';

class MovieRepo {
  final baseUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=802b2c4b88ea1183e50e6b285a27696e';

  Future<List<Results>> getResults() async {
    print('inside rep');
    var response = await http.Client().get(baseUrl);

    if (response.statusCode != 200) {
      throw Exception();
    }
    print(response);
    var jsonData = json.decode(response.body);
    List<Results> results = MovieModel.fromJson(jsonData).results;
    return results;
  }
}
