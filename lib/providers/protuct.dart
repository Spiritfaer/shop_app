import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shop_app1/models/http_exception.dart';

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

  ///Get a copy Product class withoud ID!
  Product.copy(Product prod)
      : this.id = null,
        this.title = prod.title,
        this.description = prod.description,
        this.price = prod.price,
        this.imageUrl = prod.imageUrl,
        this.isFavorite = prod.isFavorite;

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
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  void _toggleHelper(bool newStatus) {
    isFavorite = newStatus;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    bool curStatus = isFavorite;

    final url = Uri.https(
      'shop-lessons-flutter-udemy-default-rtdb.europe-west1.firebasedatabase.app',
      '/userFavorites/$userId/$id.json',
      {
        'auth': authToken,
      },
    );

    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _toggleHelper(curStatus);
      }
    } catch (error) {
      _toggleHelper(curStatus);
    }
  }

  @override
  String toString() {
    String str =
        'id:${this.id} description:${this.description} imageUrl:${this.imageUrl} price:${this.price} title:${this.title} isFavorite:${this.isFavorite}';
    return str;
  }
}
