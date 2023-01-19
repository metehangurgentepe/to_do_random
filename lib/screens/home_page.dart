import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomePage(), settings: const RouteSettings(name: routeName));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  void deleteAllTask(){
    setState(() {
      for(int i =0; i<db.toDoList.length;i++){
        db.toDoList.removeAt(i);
      }
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        leading: IconButton(
              onPressed: deleteAllTask,
              icon: Icon(Icons.delete),
            ),
      ),*/
      backgroundColor: Color(0xffEEEEEE),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color(0xff253a42),
        onPressed: createNewTask,
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body:SingleChildScrollView(child:Column(
        children: [
          Padding(padding: EdgeInsets.only(top:15),
            child:Text('To Do List',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          )),),
          db.toDoList.isEmpty ? Padding(padding: EdgeInsets.only(top:10),child:Center(child:Text('Go to random page and have fun',style: TextStyle(
            fontSize: 20
          ),))): ListView.builder(
          shrinkWrap: true,
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      )
        ],
      )),
    );
  }
}