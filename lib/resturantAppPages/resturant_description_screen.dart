import 'package:flutter/material.dart';
import 'package:week4/models/resturant_list.dart';
import 'package:week4/widgets/bookings_widget.dart';

class ResturantDescriptionScreen extends StatefulWidget {
  const ResturantDescriptionScreen({super.key, required this.resturant});
  final ResturantList resturant;

  @override
  State<ResturantDescriptionScreen> createState() => _ResturantDescriptionScreenState();
}

class _ResturantDescriptionScreenState extends State<ResturantDescriptionScreen> {
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
              widget.resturant.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.resturant.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.resturant.ratings.name),
                  const SizedBox(height: 8),
                  Text(widget.resturant.description),
                  const SizedBox(height: 8),
                  Text(widget.resturant.location),
                  const SizedBox(height: 8),
                  Text(widget.resturant.contacts),
                  const SizedBox(height: 8),
                  Text("${widget.resturant.totalTables} tables available"),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // 👈 lets it resize when keyboard opens
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => BookingsWidget(resturant: widget.resturant),
                      );
                    },
                    icon: const Icon(Icons.book_online_outlined),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}