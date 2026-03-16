import 'package:flutter/material.dart';
import 'package:week4/models/booking.dart';
import 'package:week4/models/resturant_list.dart'; // 👈 Import to access restaurantData

class BookingsListingScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  final List<Booking> bookings;

  const BookingsListingScreen({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
    required this.bookings,
  });

  @override
  State<BookingsListingScreen> createState() => BookingsListingScreenState();
}

class BookingsListingScreenState extends State<BookingsListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
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
          )
        ],
      ),
      body: widget.bookings.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_online_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    "No bookings yet!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: widget.bookings.length,
              itemBuilder: (context, index) {
                final booking = widget.bookings[index];

                // 👇 Look up restaurant from restaurantData using the id
                final resturant = restaurantData.firstWhere(
                  (r) => r.id == booking.restaurantId,
                  orElse: () => restaurantData.first, // fallback so it never crashes
                );

                return Card(
                  elevation: 8,
                  shadowColor: Colors.black26,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Restaurant Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            resturant.imageUrl, // 👈 From looked up restaurant
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Booking Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Restaurant Name
                              Text(
                                resturant.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Rating
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.orange, size: 15),
                                  const SizedBox(width: 4),
                                  Text(
                                    resturant.ratings.name,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),

                              // Location
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 15, color: Colors.redAccent),
                                  const SizedBox(width: 4),
                                  Text(
                                    resturant.location,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ],
                              ),

                              const Divider(height: 16), // 👈 Separates restaurant info from booking info

                              // Customer Name
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      size: 15, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(booking.customerName,
                                      style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                              const SizedBox(height: 4),

                              // Email
                              Row(
                                children: [
                                  const Icon(Icons.email,
                                      size: 15, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      booking.customerEmail,
                                      style: const TextStyle(fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),

                              // Date
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      size: 15, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${booking.date.day}/${booking.date.month}/${booking.date.year}',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),

                              // Guests
                              Row(
                                children: [
                                  const Icon(Icons.group,
                                      size: 15, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${booking.numberOfGuests} guests',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}