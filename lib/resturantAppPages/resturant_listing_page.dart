import 'package:flutter/material.dart';
import '../widgets/app_bottom_bar.dart';
import 'package:week4/models/resturant_list.dart';
import 'package:week4/widgets/resturant_card_widget.dart';
import 'package:week4/resturantAppPages/resturant_description_screen.dart';

class Resturantlistingpage extends StatefulWidget {
  const Resturantlistingpage({super.key});
  @override
  State<Resturantlistingpage> createState() => _Resturantlistingpage();
}

class _Resturantlistingpage extends State<Resturantlistingpage> {
  int _currentPage = 0;
  bool isDarkMode = false;

  void pageChanger(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void changeMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
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
              icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: changeMode,
            ),
          ],
        ),
        body: ListView.builder(
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
                  arguments: resturant,
                );
              },
            );
          },
        ),
        bottomNavigationBar: AppBottomBar(
          currentIndex: _currentPage,
          onTap: pageChanger,
        ),
      ),
    );
  }
}