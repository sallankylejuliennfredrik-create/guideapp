class HeritageSite {
  final String id;
  final String name;
  final String location;
  final String category;
  final String description;
  final String image;
  final String contact;

  bool isFavorite;

  HeritageSite({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.description,
    required this.image,
    this.contact = '',
    this.isFavorite = false,
  });
}