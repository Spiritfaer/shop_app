import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Product.empty()
      : this.id = null,
        this.title = null,
        this.description = null,
        this.price = 0.0,
        this.imageUrl = null,
        this.isFavorite = false;

  Product copyWith({
    String id,
    String title,
    String description,
    double price,
    String imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  @override
  String toString() {
    String str =
        'id:${this.id} description:${this.description} imageUrl:${this.imageUrl} price:${this.price} title:${this.title} isFavorite:${this.isFavorite}';
    return str;
  }
}
