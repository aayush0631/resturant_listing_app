import 'package:flutter/material.dart';
import 'package:week4/models/booking.dart';
import 'package:week4/models/resturant_list.dart';
import 'package:provider/provider.dart';
import 'package:week4/controller/bookings_controller.dart';

class BookingsWidget extends StatefulWidget {
  final ResturantList resturant;
  final Booking? existingBookings;

  const BookingsWidget({
    super.key,
    required this.resturant,
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

  ///load the values of an existing booking into the form if it exists, else keep the form empty for new booking
  @override
  void initState() {
    super.initState();
    if (widget.existingBookings != null) {
      _usernameController.text = widget.existingBookings!.customerName;
      _emailController.text = widget.existingBookings!.customerEmail;
      _noOfGuestsController.text = widget.existingBookings!.numberOfGuests.toString();
      _selectedDate = widget.existingBookings!.date;
    }
  }

  /// Dispose controllers to free up resources
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _noOfGuestsController.dispose();
    super.dispose();
  }

  /// Validate form and submit booking data
  void _submitForm() {
    late final Booking booking;

    if (_formKey.currentState!.validate()) {
      if (widget.existingBookings == null) {
        booking = Booking(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          restaurantId: widget.resturant.id,
          restaurantName: widget.resturant.name,
          customerName: _usernameController.text.trim(),
          customerEmail: _emailController.text.trim(),
          date: _selectedDate!,
          numberOfGuests: int.parse(_noOfGuestsController.text),
        );
      } else {
        booking = widget.existingBookings!.copyWith(
          customerName: _usernameController.text.trim(),
          customerEmail: _emailController.text.trim(),
          date: _selectedDate,
          numberOfGuests: int.parse(_noOfGuestsController.text),
        );
      }
      context.read<BookingsController>().addBooking(booking);
      Navigator.pop(context);
    }
  }

  void _showconfirmDialog(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('are you sure you wanna book?'),
        actions: [
          TextButton(
            onPressed: () {
              _submitForm();
              Navigator.pop(context);
            },
            child: const Text('book'),
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
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
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

                /// Name
                FormInputField(
                  controller: _usernameController,
                  label: 'Name',
                  icon: Icons.person,
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

                /// Email
                FormInputField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
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

                /// Guests
                FormInputField(
                  controller: _noOfGuestsController,
                  label: 'No of Guests',
                  icon: Icons.group,
                  keyboardType: TextInputType.number,
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

                /// Date picker
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
                              state.didChange(picked);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
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
                    onPressed: _showconfirmDialog,
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

/// Reusable form input widget
class FormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;

  const FormInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: validator,
    );
  }
}
