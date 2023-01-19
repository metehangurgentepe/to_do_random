import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random/models/movie_model.dart';
import 'package:random/services/movie_service.dart';

import '../data/database.dart';
import '../util/dialog_box.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = '/movie-detail';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => MovieDetailScreen(),
        settings: const RouteSettings(name: routeName));
  }

  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ToDoDataBase db = ToDoDataBase();

  final service = MovieService();
  String movieName = '';
  List<String> movies_title =[];
  List<String> movies_date =[];
  List<String> movies_overview =[];
  List<double> movies_vote =[];


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
        print('movie  bu sayfaya geliyor');
        setState(() {
          print('movie title aşağıda');
          print(value.title);
          movies_title.add(value.title!);
          movies_date.add(value.releaseDate!);
          movies_overview.add(value.overview!);
          movies_vote.add(value.voteAverage!);

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
        child: Icon(Icons.add,color:Colors.white),
      ),
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xff253a42),
        title: Text(
          'Random Movie ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
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
            movies_title.length>0 ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(children: [
                    ListTile(
                      title: Center(child:Text('${movies_title.last}' ?? '',style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),)),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey[600],
                    ),
                    ListTile(
                      title: Center(child:Text('${movies_overview.last}' ?? '')),
                    ),
                    ListTile(
                      title: Text('Filmin Puanı: ${movies_vote.last}/10' ?? '',textAlign: TextAlign.end,),
                    ),
                    ListTile(
                      title: Text('${movies_date.last}' ?? '',textAlign: TextAlign.end,),
                    ),
                  ]);
                }): CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }


  void createNewTask() {
    setState(() {
      db.createInitialData();
      db.loadData();
        db.toDoList.add(['${movies_title.last} watch this movie', false]);
      });
      db.updateDataBase();
  }
}
