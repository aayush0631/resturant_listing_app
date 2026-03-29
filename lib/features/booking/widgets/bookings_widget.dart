import 'package:flutter/material.dart';
import 'package:week4/core/utils/validator.dart';
import 'package:week4/data/models/booking.dart';
import 'package:week4/data/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:week4/features/booking/viewmodel/bookings_viewmodel.dart';
import 'package:week4/core/widgets/form_input_widget.dart';
import 'package:week4/core/widgets/confirmation_dialog.dart';
import 'package:week4/features/booking/viewmodel/booking_form_viewmodel.dart';
import 'package:week4/features/booking/view/booking_view.dart';

class BookingsWidget extends StatelessWidget {
  final ResturantList resturant;
  final Booking? existingBookings;

  const BookingsWidget({
    super.key,
    required this.resturant,
    this.existingBookings,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingFormViewModel(
        resturant: resturant,
        existingBooking: existingBookings,
      ),
      child: const BookingsView(),
    );
  }
}