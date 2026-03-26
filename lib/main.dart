import 'package:flutter/material.dart';
import 'package:week4/features/booking/viewmodel/bookings_viewmodel.dart';
import 'package:week4/data/models/booking.dart';
import 'package:week4/data/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:week4/routing/routes.dart';
import 'package:week4/routing/router.dart';
import 'package:flutter/services.dart';
import 'package:week4/features/booking/view/bookings_listing_screen.dart';
import 'package:week4/core/widgets/form_input_widget.dart';
import 'package:week4/features/booking/widgets/bookings_widget.dart';
import 'package:week4/features/restaurant/view/resturant_listing_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookingsController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  final List<Booking> _bookings = [];

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Resturantlistingpage(
        bookings: _bookings,
        onToggleTheme: _toggleTheme,
        themeMode: _themeMode,
      ),
      initialRoute: Routes.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
