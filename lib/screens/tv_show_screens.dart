import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random/services/tv_series_service.dart';
class TvShowScreens extends StatefulWidget {
  static const String routeName = '/tv-show';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => TvShowScreens(),
        settings: const RouteSettings(name: routeName));
  }
  const TvShowScreens({Key? key}) : super(key: key);


  @override
  State<TvShowScreens> createState() => _TvShowScreensState();
}

class _TvShowScreensState extends State<TvShowScreens> {
  final service = TvSeriesService();
  List<String> tv_show_title =[];
  List<String> tv_show_date =[];
  List<String> tv_show_overview =[];
  List<double> tv_show_vote =[];
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
          print(value.originalName);
          tv_show_title.add(value.originalName!);
          print(tv_show_title);
          tv_show_overview.add(value.overview!);
          tv_show_date.add(value.firstAirDate!);
        });
      } else {
        throw Exception('movie data null geldi');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff253a42),
        title: Text(
          'Random Tv Shows ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xffEEEEEE),
      body:Container(
        child: Column(
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
            Text('Tap the below button, generate random activity for add to do.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                )),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed: () {
                    Random random = new Random();
                    int min = 100;
                    int max = 990;
                    int randomNumber = min + random.nextInt(max - min);
                    service.generateTvShow(randomNumber);
                    Navigator.pushNamed(context,'/tv-show_detail');
                  },
                  child: Text(
                    'Random Activity',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff253a42),
                      fixedSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ))
          ],
        ),
      ),
    );
  }
}
