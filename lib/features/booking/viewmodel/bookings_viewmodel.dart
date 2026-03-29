import 'package:flutter/material.dart';
import 'package:week4/data/models/booking.dart';

class BookingsController extends ChangeNotifier{
  final List<Booking> _bookings = [];
  // 
  List<Booking> get bookings => _bookings;
  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(Booking booking) {
    _bookings.remove(booking);
    notifyListeners();
  }
}