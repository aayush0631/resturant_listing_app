import 'package:flutter/material.dart';
import 'package:week4/main.dart';
import 'package:week4/routing/routes.dart';
import 'package:week4/data/models/description_screen_args.dart';
import 'package:week4/features/restaurant/view/resturant_description_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Home Screen'))),
        );
      case Routes.description:
        final args = settings.arguments;
        if (args is DescriptionScreenArgs) {
          return MaterialPageRoute(
            builder: (context) =>
                ResturantDescriptionScreen(resturant: args.resturant),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text('Invalid arguments for description screen'),
              ),
            ),
          );
        }
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
