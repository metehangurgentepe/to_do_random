import 'package:flutter/material.dart';
import 'package:random/services/activity_service.dart';

import '../data/database.dart';

class ActivityScreen extends StatefulWidget {
  static const String routeName = '/activity-random';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => ActivityScreen(),
        settings: const RouteSettings(name: routeName));
  }

  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final service = ActivityService();
  ToDoDataBase db = ToDoDataBase();
  String activity = '';
  bool _onTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor:Color(0xff253a42),
          onPressed: createNewTask,
          child: Icon(Icons.add,color: Colors.white,),
        ),
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor:Color(0xff253a42),
        title: Text('Random Activity ',
        style: TextStyle(
          color: Colors.white
        ),),
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
              'https://images.unsplash.com/photo-1607962837359-5e7e89f86776?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
              height: 300,
              width: 300,
            ),
            _onTapped
                ? Center(
                    child: Text('$activity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )
                : Text(
                    'Tap the below button, generate random movie for add to do.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    )),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed: () {
                    _onTapped = true;
                    service.generateActivity().then((value) {
                      if (value.activity != null) {
                        print('deneme');
                        setState(() {
                          print(value.activity);
                          activity = value.activity!;
                        });
                      } else {
                        throw Exception('movie data null geldi');
                      }
                    });
                  },
                  child: Text(
                    'Random Activity',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor:Color(0xff253a42),
                      fixedSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                )),
          ],
        ),
      ),
    );
  }

  void createNewTask() {
    setState(() {
      db.createInitialData();
      db.loadData();
      db.toDoList.add([activity, false]);
    });
    db.updateDataBase();
  }
}
