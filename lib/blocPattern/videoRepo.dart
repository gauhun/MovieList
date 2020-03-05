import 'package:http/http.dart' as http;
import 'dart:convert';

import './videoModel.dart';

class VideoRepo {
  static Future<List<Resultsv>> getResults(String vID) async {
    print('inside video rep');
    var response = await http.Client().get(
        'http://api.themoviedb.org/3/movie/$vID/videos?api_key=802b2c4b88ea1183e50e6b285a27696e');

    if (response.statusCode != 200) {
      throw Exception();
    }
    print(response);
    var jsonData = json.decode(response.body);
    List<Resultsv> resultsv = VideoModel.fromJson(jsonData).vresults;
    return resultsv;
  }
}
