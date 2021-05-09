import 'package:flutter/material.dart';

import '../providers/products_provider.dart';

class ProductEditScreen extends StatefulWidget {
  static const String nameRoute = '/product-edit-screen';
  static const String nameScreen = 'Edit product\'s detail';

  const ProductEditScreen({Key key}) : super(key: key);

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductEditScreen.nameScreen),
      ),
      body: Center(
        child: Text('Edit some product'),
      ),
    );
  }
}
