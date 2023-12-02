class Mobil {
  final String name;
  final String description;
  final int rating;
  final String type;
  final String imageAsset;
  final List<String> imageUrls;
  bool isFavorite;

  Mobil({
    required this.name,
    required this.description,
    required this.rating,
    required this.type,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
  });

}

