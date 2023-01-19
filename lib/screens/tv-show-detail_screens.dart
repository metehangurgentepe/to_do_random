import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random/models/get_tv_series_model.dart';
import 'package:random/models/tv_show_model.dart';

import 'package:flutter/services.dart' as rootBundle;
import 'package:random/services/tv_series_service.dart';
import 'package:url_launcher/url_launcher.dart';


import '../data/database.dart';

class TvShowDetailScreens extends StatefulWidget {
  static const String routeName = '/tv-show_detail';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => TvShowDetailScreens(),
        settings: const RouteSettings(name: routeName));
  }
  const TvShowDetailScreens({Key? key}) : super(key: key);


  @override
  State<TvShowDetailScreens> createState() => _TvShowDetailScreensState();
}

class _TvShowDetailScreensState extends State<TvShowDetailScreens> {
  ToDoDataBase db = ToDoDataBase();
  final service = TvSeriesService();
  List<String> tv_show_title =[];
  List<String> tv_show_genres =[];
  List<String> tv_show_overview =[];
  List<String> tv_show_date =[];

  @override
  void initState() {
    Random random = new Random();
    int min = 100;
    int max = 990;
    int randomNumber = min + random.nextInt(max - min);
    super.initState();
    service.generateTvShow(randomNumber).then((value) {
      if (value.status != null) {
        print('deneme');
        print('tv showlar  bu sayfaya geliyor');
        setState(() {
          print('tv showlar title aşağıda');
          print(value.genres);
          tv_show_title.add(value.name!);
          print(tv_show_title);
          tv_show_overview.add(value.overview!);
          tv_show_date.add(value.lastAirDate);
          tv_show_genres.add(value.genres[0].name);
        });
      } else {
        throw Exception('movie data null geldi');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff253a42),
          onPressed: createNewTask,
          child: Icon(Icons.add,color: Colors.white,),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff253a42),
          title: Text(
            'Random Tv Shows ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xffEEEEEE),
      body: tv_show_title.isNotEmpty ? Container(
        child:SingleChildScrollView(child:Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 25),
              child: Center(
                child: Text('Random movie generate to do',
                    style:
                    TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
              )),
          Image.network(
            'https://images.unsplash.com/photo-1593784991188-c899ca07263b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
            height: 300,
            width: 300,
          ),
          tv_show_title.isNotEmpty ? Column(
              children: [
                  ListTile(
                    title: Center(child:Text('${tv_show_title[0]}' ?? '',style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),)),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey[600],
                  ),
                  ListTile(
                    title: Center(child:Text('${tv_show_overview[0]!}' ?? '')),
                  ),
                  ListTile(
                    title: Text('Filmin türü: ${tv_show_genres[0]!}' ?? '',textAlign: TextAlign.start,),
                  ),
                 ListTile(
                    title: Text('${tv_show_date[0]}' ?? '',textAlign: TextAlign.end,),
                  ),
                ]): CircularProgressIndicator(),

          ],
        ),
      )
      ): CircularProgressIndicator());

  }
  void createNewTask() {
    setState(() {
      db.createInitialData();
      db.loadData();
      db.toDoList.add([tv_show_title.last +' watch this tv series', false]);
    });
    db.updateDataBase();
  }
}
