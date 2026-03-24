import 'package:flutter/material.dart';
import 'package:week4/main.dart';
import 'package:week4/routing/routes.dart';
import 'package:week4/resturantAppPages/resturant_description_screen.dart';
import 'package:week4/models/description_screen_args.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        final args = settings.arguments as DescriptionScreenArgs  ?;
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Home Screen'))));
      case Routes.description:
        final args = settings.arguments as DescriptionScreenArgs;
        return MaterialPageRoute(
          builder: (context) => ResturantDescriptionScreen(
            resturant: args.resturant,
          ),
        );
      // Define routes here
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}