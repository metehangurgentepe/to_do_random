import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';


class RandomScreen extends StatefulWidget {
  static const String routeName = '/random';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => RandomScreen(),
        settings: const RouteSettings(name: routeName));
  }

  const RandomScreen({Key? key}) : super(key: key);

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {


  @override
  Widget build(BuildContext context) {
    List randomCategories = ['Movie', 'Activity', 'Books','Tv Shows'];
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1159&q=80',
      'https://images.unsplash.com/photo-1607962837359-5e7e89f86776?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'https://images.unsplash.com/photo-1513001900722-370f803f498d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'https://images.unsplash.com/photo-1593784991188-c899ca07263b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${randomCategories[imgList.indexOf(item)]} ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ))
        .toList();
    List<IconButton> randomIcons = [
      IconButton(onPressed: () {Navigator.pushNamed(context, '/movie-random');}, icon: Icon(Icons.movie_creation_outlined)),
      IconButton(onPressed: () {Navigator.pushNamed(context, '/activity-random');}, icon: Icon(Icons.local_activity_outlined)),
      IconButton(onPressed: () {Navigator.pushNamed(context, '/books-random');}, icon: Icon(Icons.book_outlined)),
      IconButton(onPressed: () {Navigator.pushNamed(context, '/tv-show');}, icon: Icon(LineIcons.television)),
    ];
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: EdgeInsets.only(),child:Container(
            height: 100,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: randomCategories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                              color: Color(0xFFF2F8FF),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Center(
                            child: randomIcons[index],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          randomCategories[index],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  );
                }))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Center(
              child: Text(
                  'Do you want random actions? So you tap buttons and have fun!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),),
            )),
        Container(
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items: imageSliders,
            )),


    ]),
    );

  }
}
