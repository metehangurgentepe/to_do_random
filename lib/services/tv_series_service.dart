import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:random/models/get_tv_series_model.dart';
import 'package:random/models/movie_model.dart';
import 'package:http/http.dart' as http;


class TvSeriesService{
  Future<GetTvShowModel> generateTvShow(int randomNumber) async {
    String url = 'https://api.themoviedb.org/3/tv/$randomNumber?api_key=1771d0ed4cb42b83b8b94fbe2102e24c';
    final result= await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if(result.statusCode==200){
      print('tv show dataları burada');
      print(result.body);
      return GetTvShowModel.fromJson(jsonDecode(result.body));
    }
    else{
      throw Exception('İstek başarısız oldu ${result.statusCode}');
    }
  }

}