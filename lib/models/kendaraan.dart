class Kendaraan {
  final int id;
  final String kendaraan;
  final String name;
  final String description;
  final int harga;
  final int rating;
  final String type;
  final String imageAsset;
  final List<String> imageUrls;
  bool onRent;
  bool Rate;
  bool Rating;

  Kendaraan({
    required this.id,
    required this.kendaraan,
    required this.name,
    required this.description,
    required this.harga,
    required this.rating,
    required this.type,
    required this.imageAsset,
    required this.imageUrls,
    this.Rate = true,
    this.Rating = false,
    this.onRent = false,
  });
}
