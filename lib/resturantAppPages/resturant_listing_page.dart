import 'package:flutter/material.dart';
import 'package:week4/widgets/app_bottom_bar.dart';
import 'package:week4/models/resturant_list.dart';
import 'package:week4/widgets/resturant_card_widget.dart';
import 'package:week4/models/booking.dart';
import 'package:week4/resturantAppPages/bookings_listing_screen.dart';
import 'package:week4/main.dart';
import 'package:week4/routing/routes.dart';
import 'package:week4/models/description_screen_args.dart';
import 'package:provider/provider.dart';
import 'package:week4/controller/bookings_controller.dart';

/// The main page displaying a list of restaurants and navigation tabs.
///
/// Uses [AppBottomBar] for navigation and shows either
/// the restaurant list, bookings list, or settings placeholder.
class Resturantlistingpage extends StatefulWidget {
  /// Callback to toggle light/dark theme.
  final VoidCallback onToggleTheme;

  /// Current theme mode.
  final ThemeMode themeMode;

  /// List of current bookings.
  final List<Booking> bookings;

  const Resturantlistingpage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
    required this.bookings,
  });

  @override
  State<Resturantlistingpage> createState() => _Resturantlistingpage();
}

class _Resturantlistingpage extends State<Resturantlistingpage> {
  /// Index of the currently selected bottom navigation tab.
  int _currentPage = 0;

  /// Changes the current page based on [index].
  void pageChanger(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _RestaurantListBody(onAddBooking: context.read<BookingsController>().addBooking),
      BookingsListingScreen(
        onToggleTheme: widget.onToggleTheme,
        themeMode: widget.themeMode,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
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
              widget.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
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

/// Body of the restaurant listing page showing a list of restaurants.
///
/// Uses [ResturantWidget] for each restaurant item, and
/// navigates to [DescriptionScreenArgs] when tapped.
class _RestaurantListBody extends StatelessWidget {
  /// Callback to add a new [Booking] when a restaurant is selected.
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
              arguments: DescriptionScreenArgs(
                resturant: resturant,
              ),
            );
          },
        );
      },
    );
  }
}