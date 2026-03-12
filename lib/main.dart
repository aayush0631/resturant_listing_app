import 'package:flutter/material.dart';
// import 'package:week4/models/exercise1.dart';
// import 'package:week4/week4/exercise2.dart';
import 'package:week4/resturantAppPages/resturant_listing_page.dart';
import 'package:week4/resturantAppPages/resturant_description_screen.dart';
import 'package:week4/models/resturant_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // starting route
      routes: {
        '/': (context) => const Resturantlistingpage(),
        // Named route for description screen – we'll pass arguments via RouteSettings
        '/description': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as ResturantList;
          return ResturantDescriptionScreen(resturant: args);
        },
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//     @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: ShopScreen(user: user1,product: [product1],));
//   }
// }