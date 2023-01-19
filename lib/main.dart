import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home.dart';
import 'models/app_router.dart';
import 'screens/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(primarySwatch: Colors.yellow),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: HomePage.routeName,
    );
  }
}