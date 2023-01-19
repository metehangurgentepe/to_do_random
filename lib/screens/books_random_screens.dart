import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:random/models/books_model.dart';
class BooksScreen extends StatefulWidget {
  static const String routeName = '/books-random';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BooksScreen(),
        settings: const RouteSettings(name: routeName));
  }
  const BooksScreen({Key? key}) : super(key: key);


  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff253a42),
        title: Text(
          'Random Books ',
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
            SizedBox(height: 20),
            Image.network(
              'https://images.unsplash.com/photo-1513001900722-370f803f498d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20),

            Text('Tap the below button, generate random books for add to do.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                )),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/books_detail');

                    },
                  child: Text(
                    'Random Books',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff253a42),
                      fixedSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                )),
          ],
        ),
      ),
    );
  }




}



