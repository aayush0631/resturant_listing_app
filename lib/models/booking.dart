class Booking {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String customerName;
  final String customerEmail;
  final DateTime date;
  final int numberOfGuests;

  Booking({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.customerName,
    required this.customerEmail,
    required this.date,
    required this.numberOfGuests,
  });
}