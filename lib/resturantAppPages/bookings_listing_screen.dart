import 'package:flutter/material.dart';
import 'package:week4/models/booking.dart';
import 'package:week4/models/resturant_list.dart';
import 'package:week4/widgets/bookings_widget.dart'; // 👈 Import to access restaurantData

class BookingsListingScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  final List<Booking> bookings;
  final Function(Booking) onAddBooking;

  const BookingsListingScreen({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
    required this.bookings,
    required this.onAddBooking,
  });

  @override
  State<BookingsListingScreen> createState() => BookingsListingScreenState();
}

class BookingsListingScreenState extends State<BookingsListingScreen> {
  void _deleteBooking(Booking booking){
    setState(() {
      widget.bookings.remove(booking);
    });
  }
  void alertDialog(Booking booking){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('delete?'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteBooking(booking);
              Navigator.pop(context);
            } ,
            child: const Text('delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop( context), 
            child: const Text('cancle')
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
  return widget.bookings.isEmpty
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

            final resturant = restaurantData.firstWhere(
              (r) => r.id == booking.restaurantId,
              orElse: () => restaurantData.first,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        resturant.imageUrl,
                        height: 110,
                        width: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resturant.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

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

                          const Divider(height: 16),

                          Row(
                            children: [
                              const Icon(Icons.person,
                                  size: 15, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                booking.customerName,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

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
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => alertDialog(booking),
                            icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () => {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true, 
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                builder: (context) => BookingsWidget(
                                  resturant: resturant,
                                  onAddBooking:widget.onAddBooking
                                ),
                              )
                            },
                          icon: Icon(Icons.edit)
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
  }
}