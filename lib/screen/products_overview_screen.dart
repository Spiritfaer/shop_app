import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProtuctsOverviewScreen extends StatelessWidget {
  static const String nameRoute = '/products-overview-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: ProductsGrid(),
    );
  }
}
