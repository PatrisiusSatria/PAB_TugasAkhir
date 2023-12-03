class Mobil {
  final int id;
  final String name;
  final String description;
  final int harga;
  final int rating;
  final String type;
  final String imageAsset;
  final List<String> imageUrls;
  bool isFavorite;

  Mobil({
    required this.id,
    required this.name,
    required this.description,
    required this.harga,
    required this.rating,
    required this.type,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
  });

}

