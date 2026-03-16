import 'package:flutter/material.dart';
import 'package:week4/models/booking.dart';
// import 'package:week4/models/exercise1.dart';
// import 'package:week4/week4/exercise2.dart';
import 'package:week4/resturantAppPages/resturant_listing_page.dart';
import 'package:week4/resturantAppPages/resturant_description_screen.dart';
import 'package:week4/models/resturant_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }
  final List<Booking> _bookings=[];
  void _addBooking(Booking booking) {
    setState(() => _bookings.add(booking)); // 👈 Updates everywhere
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => Resturantlistingpage(
              bookings: _bookings,
              onAddBooking: _addBooking,
              onToggleTheme: _toggleTheme,
              themeMode: _themeMode,
            ),
        '/description': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>; // 👈 Map not ResturantList
          return ResturantDescriptionScreen(
            resturant: args['resturant'] as ResturantList,
            onAddBooking: args['onAddBooking'] as Function(Booking), // 👈 Pass it down
          );
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