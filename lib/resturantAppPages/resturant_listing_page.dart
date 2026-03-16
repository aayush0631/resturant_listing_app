import 'package:flutter/material.dart';
import '../widgets/app_bottom_bar.dart';
import 'package:week4/models/resturant_list.dart';
import 'package:week4/widgets/resturant_card_widget.dart';
import 'package:week4/models/booking.dart';
import 'package:week4/resturantAppPages/bookings_listing_screen.dart';

class Resturantlistingpage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  final List<Booking> bookings;         
  final Function(Booking) onAddBooking; 
  
  const Resturantlistingpage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
    required this.bookings,
    required this.onAddBooking,
  });

  @override
  State<Resturantlistingpage> createState() => _Resturantlistingpage();
}

class _Resturantlistingpage extends State<Resturantlistingpage> {
  int _currentPage = 0;

  void pageChanger(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[
    _RestaurantListBody(onAddBooking: widget.onAddBooking),
    BookingsListingScreen(
      bookings: widget.bookings,
      onToggleTheme: widget.onToggleTheme,
      themeMode: widget.themeMode,
    ),
    const Center(child: Text("Settings coming soon")),
  ];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Restaurants"),
          centerTitle: true,
          backgroundColor: Colors.red.shade600,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          leading: const Icon(Icons.restaurant_menu),
          actions: [
            IconButton(
              onPressed: widget.onToggleTheme,
              icon: Icon(
                widget.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
              ),
            )
          ],
        ),
        body: pages[_currentPage],
        bottomNavigationBar: AppBottomBar(
          currentIndex: _currentPage,
          onTap: pageChanger,
        ),
    );
  }
}
class _RestaurantListBody extends StatelessWidget {
  final Function(Booking) onAddBooking;

  const _RestaurantListBody({required this.onAddBooking});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: restaurantData.length,
      itemBuilder: (context, index) {
        final resturant = restaurantData[index];
        return ResturantWidget(
          resturant: resturant,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/description',
              arguments: {
                'resturant': resturant,
                'onAddBooking': onAddBooking,
              },
            );
          },
        );
      },
    );
  }
}