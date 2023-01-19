import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:random/models/activity_model.dart';
import 'package:random/models/movie_model.dart';
import 'package:http/http.dart' as http;


class ActivityService{
  Future<ActivityModel> generateActivity() async {
    String url = 'https://www.boredapi.com/api/activity';
    final result= await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if(result.statusCode==200){
      print('activity dataları burda');
      print(result.body);
      return ActivityModel.fromJson(jsonDecode(result.body));
    }
    else{
      throw Exception('İstek başarısız oldu ${result.statusCode}');
    }
  }

}