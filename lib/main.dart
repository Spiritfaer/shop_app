import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String defRoute = '/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.orange,
          fontFamily: 'Lato',
        ),
        routes: {
          MyApp.defRoute: (ctx) => ProtuctsOverviewScreen(),
          ProductDetailScreen.nameRoute: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
