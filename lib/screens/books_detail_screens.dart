import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:random/models/books_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/database.dart';

class BooksDetailScreen extends StatefulWidget {
  static const String routeName = '/books_detail';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BooksDetailScreen(),
        settings: const RouteSettings(name: routeName));
  }

  const BooksDetailScreen({Key? key}) : super(key: key);

  @override
  State<BooksDetailScreen> createState() => _BooksDetailScreenState();
}

class _BooksDetailScreenState extends State<BooksDetailScreen> {
  ToDoDataBase db = ToDoDataBase();

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int min = 0;
    int max = 100;
    int randomNumber = min + random.nextInt(max - min);
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xff253a42),
        title: Text(
          'Random Books ',
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
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image.network(
                  'https://images.unsplash.com/photo-1513001900722-370f803f498d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                  height: 300,
                  width: 300,
                )),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: FutureBuilder(
                    future: ReadJsonData(),
                    builder: (context, data) {
                      if (data.hasError) {
                        return Text('${data.error}');
                      } else if (data.hasData) {
                        var items = data.data as List<BooksModel>;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              void createNewTask() {
                                setState(() {
                                  db.createInitialData();
                                  db.loadData();
                                  db.toDoList.add([
                                    items[randomNumber].title! +
                                        ' read this book',
                                    false
                                  ]);
                                });
                                db.updateDataBase();
                              }

                              return Column(children: [
                                ListTile(
                                  title: Text(items[randomNumber].title!),
                                  subtitle: Text(items[randomNumber].author!),
                                  trailing: Text(
                                      items[randomNumber].year!.toString()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    String url = items[randomNumber].link!;
                                    launch(url);
                                  },
                                  child: Text(
                                    'Visit book website',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Color(0xff253a42),
                                      fixedSize: Size(200, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 155, left: 330),
                                  child: FloatingActionButton(
                                    backgroundColor: Color(0xff253a42),
                                    onPressed: createNewTask,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ]);
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }

  Future<List<BooksModel>> ReadJsonData() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/books.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => BooksModel.fromJson(e)).toList();
  }
}
