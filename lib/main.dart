import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './screen/cart_screen.dart';
import './providers/products_provider.dart';
import './providers/orders.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String defRoute = '/';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.orange,
          scaffoldBackgroundColor: Color.fromRGBO(255, 255, 230, 1),
          fontFamily: 'Lato',
          textTheme: Theme.of(context).textTheme.copyWith(
                headline1: TextStyle(color: Colors.white),
              ),
        ),
        routes: {
          MyApp.defRoute: (ctx) => ProtuctsOverviewScreen(),
          ProductDetailScreen.nameRoute: (ctx) => ProductDetailScreen(),
          CartScreen.nameRoute: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
