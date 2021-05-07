import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../model/protuct.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String nameRoute = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final String prodID = ModalRoute.of(context).settings.arguments as String;
    final Product product =
        Provider.of<ProductsProvider>(context, listen: false).findById(prodID);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
