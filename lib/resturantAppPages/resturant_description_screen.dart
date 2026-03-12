import 'package:flutter/material.dart';
import 'package:week4/models/resturant_list.dart';

class ResturantDescriptionScreen extends StatelessWidget {
  const ResturantDescriptionScreen({super.key, required this.resturant});
  final ResturantList resturant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
        centerTitle: true,
        backgroundColor: Colors.red.shade600,
        elevation: 4,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              resturant.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resturant.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(resturant.ratings.name),
                  const SizedBox(height: 8),
                  Text(resturant.description),
                  const SizedBox(height: 8),
                  Text(resturant.location),
                  const SizedBox(height: 8),
                  Text(resturant.contacts),
                  const SizedBox(height: 8),
                  Text("${resturant.totalTables} tables available"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}