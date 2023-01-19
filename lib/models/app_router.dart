import 'package:flutter/material.dart';
import 'package:random/screens/activity_random_screens.dart';
import 'package:random/screens/books_detail_screens.dart';
import 'package:random/screens/books_random_screens.dart';
import 'package:random/screens/movie_detail_screen.dart';
import 'package:random/screens/movie_random_screen.dart';
import 'package:random/screens/tv-show-detail_screens.dart';
import 'package:random/screens/tv_show_screens.dart';

import '../screens/home_page.dart';
import '../screens/random_screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    ('The Router is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomePage.route();
      case RandomScreen.routeName:
        return RandomScreen.route();
      case ActivityScreen.routeName:
        return ActivityScreen.route();
      case BooksScreen.routeName:
        return BooksScreen.route();
      case MovieRandomScreen.routeName:
        return MovieRandomScreen.route();
      case TvShowScreens.routeName:
        return TvShowScreens.route();
      case MovieDetailScreen.routeName:
        return  MovieDetailScreen.route();
      case BooksDetailScreen.routeName:
        return  BooksDetailScreen.route();
      case TvShowDetailScreens.routeName:
        return  TvShowDetailScreens.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          Scaffold(
            appBar: AppBar(title: Text('error')),
          ),
      settings: RouteSettings(name: '/error'),
    );
  }
}