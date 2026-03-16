import 'package:flutter/material.dart';
import 'package:week4/models/booking.dart';
import 'package:week4/models/resturant_list.dart';
import 'package:week4/widgets/bookings_widget.dart';

/// Reusable Icon + Text widget
class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final double iconSize;
  final TextStyle? textStyle;

  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.iconSize = 15,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? Colors.grey, size: iconSize),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}

/// Main screen showing list of bookings
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
  void _deleteBooking(Booking booking) {
    setState(() {
      widget.bookings.remove(booking);
    });
  }

  void _showDeleteDialog(Booking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete?'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteBooking(booking);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bookings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_online_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              "No bookings yet!",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
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
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Restaurant Image
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
                /// Booking Information
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
                      IconText(
                        icon: Icons.star,
                        text: resturant.ratings.name,
                        iconColor: Colors.orange,
                      ),
                      const SizedBox(height: 4),
                      IconText(
                        icon: Icons.location_on,
                        text: resturant.location,
                        iconColor: Colors.redAccent,
                      ),
                      const Divider(height: 16),
                      IconText(icon: Icons.person, text: booking.customerName),
                      const SizedBox(height: 4),
                      IconText(icon: Icons.email, text: booking.customerEmail),
                      const SizedBox(height: 4),
                      IconText(
                        icon: Icons.calendar_today,
                        text:
                            '${booking.date.day}/${booking.date.month}/${booking.date.year}',
                      ),
                      const SizedBox(height: 4),
                      IconText(
                        icon: Icons.group,
                        text: '${booking.numberOfGuests} guests',
                      ),
                    ],
                  ),
                ),
                /// Action Buttons
                Column(
                  children: [
                    IconButton(
                      onPressed: () => _showDeleteDialog(booking),
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => BookingsWidget(
                            resturant: resturant,
                            onAddBooking: widget.onAddBooking,
                            existingBookings: booking,
                          ),
                        );
                        _deleteBooking(booking);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}