import 'package:flutter/material.dart';

import '../model/protuct.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key key, this.title}) : super(key: key);

  static const String nameRoute = '/product-detail-screen';

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
