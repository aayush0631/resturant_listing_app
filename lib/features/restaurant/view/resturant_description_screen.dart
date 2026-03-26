import 'package:flutter/material.dart';
import 'package:week4/data/models/booking.dart';
import 'package:week4/data/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:week4/features/booking/widgets/bookings_widget.dart';

class ResturantDescriptionScreen extends StatelessWidget {
  final ResturantList resturant;

  const ResturantDescriptionScreen({
    super.key,
    required this.resturant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        centerTitle: true,
        backgroundColor: Colors.red,
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
                  Text(
                    resturant.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(resturant.ratings.name),
                  const SizedBox(height: 8),
                  Text(resturant.description),
                  const SizedBox(height: 8),
                  Text(resturant.location),
                  const SizedBox(height: 8),
                  Text(resturant.contacts),
                  const SizedBox(height: 8),
                  Text('${resturant.totalTables} tables available'),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => BookingsWidget(
                              resturant: resturant,
                            ),
                          );
                        },
                        icon: const Icon(Icons.book_online_outlined),
                      ),
                      const Text('make booking'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
