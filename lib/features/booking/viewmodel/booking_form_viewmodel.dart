import 'package:flutter/material.dart';
import 'package:week4/data/models/booking.dart';
import 'package:week4/data/models/restaurant.dart';

/// ViewModel for managing booking form state and logic.
///
/// Responsibilities:
/// - Manage form controllers
/// - Handle selected date
/// - Perform submission logic
/// - Support both create & edit booking
class BookingFormViewModel extends ChangeNotifier {
  final ResturantList resturant;
  final Booking? existingBooking;

  BookingFormViewModel({
    required this.resturant,
    this.existingBooking,
  }) {
    _initialize();
  }

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final guestsController = TextEditingController();

  DateTime? selectedDate;

  /// Initialize form values (for edit case)
  void _initialize() {
    if (existingBooking != null) {
      usernameController.text = existingBooking!.customerName;
      emailController.text = existingBooking!.customerEmail;
      guestsController.text =
          existingBooking!.numberOfGuests.toString();
      selectedDate = existingBooking!.date;
    }
  }

  /// Set selected date
  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  /// Validate form
  bool validate() {
    return formKey.currentState!.validate() && selectedDate != null;
  }

  /// Build booking object
  Booking buildBooking() {
    if (existingBooking == null) {
      return Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        restaurantId: resturant.id,
        restaurantName: resturant.name,
        customerName: usernameController.text.trim(),
        customerEmail: emailController.text.trim(),
        date: selectedDate!,
        numberOfGuests: int.parse(guestsController.text),
      );
    } else {
      return existingBooking!.copyWith(
        customerName: usernameController.text.trim(),
        customerEmail: emailController.text.trim(),
        date: selectedDate,
        numberOfGuests: int.parse(guestsController.text),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    guestsController.dispose();
    super.dispose();
  }
}