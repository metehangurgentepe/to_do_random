import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random/models/movie_model.dart';
import 'package:random/services/movie_service.dart';

class MovieRandomScreen extends StatefulWidget {
  static const String routeName = '/movie-random';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => MovieRandomScreen(),
        settings: const RouteSettings(name: routeName));
  }

  const MovieRandomScreen({Key? key}) : super(key: key);

  @override
  State<MovieRandomScreen> createState() => _MovieRandomScreenState();
}

class _MovieRandomScreenState extends State<MovieRandomScreen> {
  final service = MovieService();
  String movieName = '';
  List<String> movies =[];

  @override
  void initState() {
    Random random = new Random();
    int min = 100;
    int max = 990;
    int randomNumber = min + random.nextInt(max - min);
    super.initState();
    service.generateMovie(randomNumber).then((value) {
      if (value.status != null) {
        print('deneme');
        setState(() {
          print(value.title);
          movies[0] = value.title!;
        });
      } else {
        throw Exception('movie data null geldi');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xff253a42),
        title: Text(
          'Random Movie ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
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
              'https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1159&q=80',
              height: 300,
              width: 300,
            ),
            Text('Tap the below button, generate random movie for add to do.',
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
                    service.generateMovie(randomNumber);
                    Navigator.pushNamed(context, '/movie-detail');
                  },
                  child: Text(
                    'Random Movie',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff253a42),
                      fixedSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                )),
            movies.isEmpty ? Text('') : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  print(movies);
                  return Column(children: [
                    ListTile(
                      title: Text('${movies[0]}' ?? ''),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey[600],
                    )
                  ]);
                }),
          ],
        ),
      ),
    );
  }
}
