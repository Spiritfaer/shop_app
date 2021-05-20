import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './screen/cart_screen.dart';
import './screen/orders_screen.dart';
import './screen/user_manage_screen.dart';
import './screen/product_edit_screen.dart';
import './screen/auth_screen.dart';
import './providers/products_provider.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './providers/auth.dart';

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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (ctx) => ProductsProvider(),
          update: (ctx, auth, previousProducts) => ProductsProvider.update(
            auth.token,
            auth.user,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, auth, previousOrders) => Orders.update(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
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
            MyApp.defRoute: (ctx) =>
                auth.isAuth ? ProtuctsOverviewScreen() : AuthScreen(),
            ProtuctsOverviewScreen.nameRoute: (ctx) => ProtuctsOverviewScreen(),
            ProductDetailScreen.nameRoute: (ctx) => ProductDetailScreen(),
            CartScreen.nameRoute: (ctx) => CartScreen(),
            OrderScreen.nameRoute: (ctx) => OrderScreen(),
            UserManageScreen.nameRoute: (ctx) => UserManageScreen(),
            ProductEditScreen.nameRoute: (ctx) => ProductEditScreen(),
            AuthScreen.nameRoute: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
