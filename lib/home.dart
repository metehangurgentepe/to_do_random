import 'package:flutter/material.dart';

import 'data/database.dart';
import 'screens/home_page.dart';
import 'screens/random_screens.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => Home(),
        settings: const RouteSettings(name: routeName));
  }

  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  ToDoDataBase db = ToDoDataBase();
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    HomePage(),
    RandomScreen(),
    // TODO: Replace with ExploreScreen
  ];

  bool _tapped=false;

  void _onItemTapped(int index) {
    setState(() {
      _tapped=true;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff253a42),
        title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Random todo',
              style:TextStyle(
                  color: Colors.white
              ),
            ),
           /* IconButton(
              onPressed: deleteAllTask,
              icon: Icon(Icons.delete),
            ),*/
          ],
        )
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 14),
        selectedItemColor: Color(0xff253a42),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color:Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle,
              color: Colors.black,),
            label: 'Random',
          ),
        ],
      ),
    );
  }
  void deleteAllTask(){
    setState(() {
      for(int i =0; i<db.toDoList.length;i++){
        db.toDoList.removeAt(i);
      }
    });
    db.updateDataBase();
  }

}
