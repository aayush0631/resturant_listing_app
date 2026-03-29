import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week4/core/utils/validator.dart';
import 'package:week4/core/widgets/confirmation_dialog.dart';
import 'package:week4/core/widgets/form_input_widget.dart';
import 'package:week4/features/booking/viewmodel/booking_form_viewmodel.dart';
import 'package:week4/features/booking/viewmodel/bookings_viewmodel.dart';

class BookingsView extends StatelessWidget {
  const BookingsView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingFormViewModel>();

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
            key: vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book at ${vm.resturant.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                /// Name
                FormInputField(
                  controller: vm.usernameController,
                  label: 'Name',
                  icon: Icons.person,
                  validator: Validator.name,
                ),

                const SizedBox(height: 16),

                /// Email
                FormInputField(
                  controller: vm.emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validator.email,
                ),

                const SizedBox(height: 16),

                /// Guests
                FormInputField(
                  controller: vm.guestsController,
                  label: 'No of Guests',
                  icon: Icons.group,
                  keyboardType: TextInputType.number,
                  validator: Validator.noOfGuests,
                ),

                const SizedBox(height: 16),

                /// Date picker
                _DatePickerField(),

                const SizedBox(height: 20),

                /// Submit button
                ElevatedButton(
                  onPressed: () async {
                    if (!vm.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please complete all fields'),
                        ),
                      );
                      return;
                    }

                    final confirm = await conformationDialog(
                      context: context,
                      title: 'Confirm Booking',
                      content: 'Confirm booking at ${vm.resturant.name}?',
                      confirmText: 'Book',
                    );

                    if (confirm == true) {
                      final booking = vm.buildBooking();
                      context.read<BookingsController>().addBooking(booking);

                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text('Confirm Booking'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DatePickerField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingFormViewModel>();

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );

        if (picked != null) {
          vm.setDate(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Text(
          vm.selectedDate == null
              ? 'Select Date'
              : '${vm.selectedDate!.day}/${vm.selectedDate!.month}/${vm.selectedDate!.year}',
        ),
      ),
    );
  }
}
