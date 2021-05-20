import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app1/models/http_exception.dart';

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final String mainUrl =
      'shop-lessons-flutter-udemy-default-rtdb.europe-west1.firebasedatabase.app';
  List<OrderItem> _orders = [];
  final String authToken;

  Orders() : authToken = null;
  Orders.update(this.authToken, orders) : _orders = orders;

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetorders() async {
    final url = Uri.https(
      mainUrl,
      '/orders.json',
      {
        'auth': authToken,
      },
    );
    final response = await http.get(url);
    List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((ordersId, orderData) {
      loadedOrders.insert(
        0,
        OrderItem(
            id: ordersId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']);
            }).toList()),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double totalAmount) async {
    final url = Uri.https(
      mainUrl,
      '/orders.json',
      {
        'auth': authToken,
      },
    );
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': totalAmount,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList()
          }));
      _orders.insert(
          0,
          OrderItem(
            id: jsonDecode(response.body)['name'],
            dateTime: timeStamp,
            amount: totalAmount,
            products: cartProducts,
          ));
      if (response.statusCode >= 400) {
        throw HttpException(response.statusCode.toString());
      }
    } catch (error) {
      throw error;
    } finally {
      notifyListeners();
    }
  }
}
