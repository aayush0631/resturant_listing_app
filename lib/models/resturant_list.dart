enum Ratings {poor,average,good,verygood,excelent}

class ResturantList {
  String id;
  String name;
  Ratings ratings;
  String description;
  String contacts;
  String location;
  String imageUrl;
  int totalTables;

  ResturantList({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.contacts,
    required this.totalTables,
    required this.ratings,
  });
}
final List<ResturantList> restaurantData = [
  ResturantList(
    id: "1",
    name: "Burger House",
    ratings: Ratings.good,
    description: "Popular place for burgers and fast food.",
    contacts: "9800000001",
    location: "Kathmandu",
    imageUrl: "https://picsum.photos/200/300?1",
    totalTables: 15,
  ),

  ResturantList(
    id: "2",
    name: "Momo Palace",
    ratings: Ratings.excelent,
    description: "Famous for authentic Nepali momo.",
    contacts: "9800000002",
    location: "Lalitpur",
    imageUrl: "https://picsum.photos/200/300?2",
    totalTables: 20,
  ),

  ResturantList(
    id: "3",
    name: "Pizza World",
    ratings: Ratings.verygood,
    description: "Best Italian pizza in town.",
    contacts: "9800000003",
    location: "Bhaktapur",
    imageUrl: "https://picsum.photos/200/300?3",
    totalTables: 12,
  ),

  ResturantList(
    id: "4",
    name: "Himalayan Kitchen",
    ratings: Ratings.good,
    description: "Traditional Nepali and Tibetan dishes.",
    contacts: "9800000004",
    location: "Thamel",
    imageUrl: "https://picsum.photos/200/300?4",
    totalTables: 18,
  ),

  ResturantList(
    id: "5",
    name: "Cafe Aroma",
    ratings: Ratings.average,
    description: "Cozy cafe with coffee and desserts.",
    contacts: "9800000005",
    location: "Boudha",
    imageUrl: "https://picsum.photos/200/300?5",
    totalTables: 10,
  ),
];