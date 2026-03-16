import 'package:flutter/material.dart';
import 'package:week4/models/booking.dart';
import 'package:week4/models/resturant_list.dart';

class BookingsWidget extends StatefulWidget {
  final ResturantList resturant;
  final Function(Booking) onAddBooking;
  final Booking? existingBookings;

  const BookingsWidget({
    super.key,
    required this.resturant,
    required this.onAddBooking,
    this.existingBookings,
  });

  @override
  State<BookingsWidget> createState() => _BookingsWidgetState();
}

class _BookingsWidgetState extends State<BookingsWidget> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _noOfGuestsController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.existingBookings != null) {
      _usernameController.text = widget.existingBookings!.customerName;
      _emailController.text = widget.existingBookings!.customerEmail;
      _noOfGuestsController.text = widget.existingBookings!.numberOfGuests
          .toString();
      _selectedDate = widget.existingBookings!.date;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _noOfGuestsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    late final Booking booking;
    if (widget.existingBookings == null) {
      if (_formKey.currentState!.validate()) {
        booking = Booking(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          restaurantId: widget.resturant.id,
          restaurantName: widget.resturant.name,
          customerName: _usernameController.text.trim(),
          customerEmail: _emailController.text.trim(),
          date: _selectedDate!,
          numberOfGuests: int.parse(_noOfGuestsController.text),
        );
      }
    } else {
      booking = widget.existingBookings!.copyWith(
        customerName: _usernameController.text.trim(),
        customerEmail: _emailController.text.trim(),
        date: _selectedDate,
        numberOfGuests: int.parse(_noOfGuestsController.text),
      );
    }
    widget.onAddBooking(booking);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return SingleChildScrollView(
          // 👈 prevents overflow when keyboard opens
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                20, // 👈 keyboard push up
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Book at ${widget.resturant.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // No of Guests
                TextFormField(
                  controller: _noOfGuestsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'No of Guests',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.group),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter number of guests';
                    }
                    final guest = int.tryParse(value);
                    if (guest == null || guest < 1) {
                      return 'Please enter a valid number';
                    }
                    if (guest > 20) {
                      return 'Max guests is 20';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Date — using FormField so it validates with the rest of the form
                FormField<DateTime>(
                  validator: (value) {
                    if (value == null) return 'Please select a date';
                    return null;
                  },
                  builder: (FormFieldState<DateTime> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 30),
                              ),
                            );
                            if (picked != null) {
                              setState(() => _selectedDate = picked);
                              state.didChange(
                                picked,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                // 👈 red border if error, grey if not
                                color: state.hasError
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _selectedDate == null
                                      ? 'Select a Date'
                                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                  style: TextStyle(
                                    color: _selectedDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 12),
                            child: Text(
                              state.errorText!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Confirm Booking'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
