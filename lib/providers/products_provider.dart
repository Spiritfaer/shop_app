import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app1/models/http_exception.dart';

import 'protuct.dart';

class ProductsProvider with ChangeNotifier {
  final String mainUrl =
      'shop-lessons-flutter-udemy-default-rtdb.europe-west1.firebasedatabase.app';
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  ProductsProvider()
      : authToken = null,
        userId = null;

  ProductsProvider.update(this.authToken, this.userId, item) : _items = item;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorite {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProductsData([bool filterByUser = false]) async {
    var queryParameters = {
      'auth': authToken,
    };
    if (filterByUser) {
      queryParameters.addAll({
        'orderBy': json.encode('creatorId'),
        'equalTo': json.encode(userId),
      });
    }
    var url = Uri.https(mainUrl, '/products.json', queryParameters);
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Error status in porduct provider');
      }
      final fetchData = json.decode(response.body) as Map<String, dynamic>;
      if (fetchData == null) {
        return;
      }

      url = Uri.https(
        mainUrl,
        '/userFavorites/$userId.json',
        {
          'auth': authToken,
        },
      );
      final favoriteResponse = await http.get(url);
      final favoditeData = json.decode(favoriteResponse.body);

      List<Product> loadedProducts = [];
      fetchData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite:
                favoditeData == null ? false : favoditeData[prodId] ?? false,
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      //TODO add an error handler at the call site
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
      mainUrl,
      '/products.json',
      {
        'auth': authToken,
      },
    );
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      );
      final newProduct = Product.copy(product)
          .copyWith(id: json.decode(response.body)['name']);
      //-----
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteById(String id) async {
    try {
      final url = Uri.https(
        mainUrl,
        '/products/$id.json',
        {
          'auth': authToken,
        },
      );
      final response = await http.delete(url);
      if (response.statusCode < 400) {
        _items.removeWhere((product) => product.id == id);
      } else {
        throw HttpException('Object didn\'t delete');
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateProduct(String id, Product updatedProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      final url = Uri.https(
        mainUrl,
        '/products/$id.json',
        {
          'auth': authToken,
        },
      );
      try {
        await http.patch(url,
            body: json.encode({
              'title': updatedProduct.title,
              'description': updatedProduct.description,
              'imageUrl': updatedProduct.imageUrl,
              'price': updatedProduct.price,
            }));
        _items[productIndex] = updatedProduct;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {
      print('...');
    }
  }
}
