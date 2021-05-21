import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './screen/cart_screen.dart';
import './screen/orders_screen.dart';
import './screen/user_manage_screen.dart';
import './screen/product_edit_screen.dart';
import './screen/auth_screen.dart';
import './screen/splah_screen.dart';
import './helpers/custom_route.dart';
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
            auth.user,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) {
          ifAuth(targetScreen) => auth.isAuth ? targetScreen : AuthScreen();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.teal,
              accentColor: Colors.orange,
              scaffoldBackgroundColor: Color.fromRGBO(255, 255, 230, 1),
              fontFamily: 'Lato',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
              }),
              textTheme: Theme.of(context).textTheme.copyWith(
                    headline1: TextStyle(color: Colors.white),
                  ),
            ),
            routes: {
              MyApp.defRoute: (ctx) => auth.isAuth
                  ? ProtuctsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SplashScreen();
                        } else {
                          return AuthScreen();
                        }
                      },
                    ),
              ProtuctsOverviewScreen.nameRoute: (ctx) =>
                  ifAuth(ProtuctsOverviewScreen()),
              ProductDetailScreen.nameRoute: (ctx) =>
                  ifAuth(ProductDetailScreen()),
              CartScreen.nameRoute: (ctx) => ifAuth(CartScreen()),
              OrderScreen.nameRoute: (ctx) => ifAuth(OrderScreen()),
              UserManageScreen.nameRoute: (ctx) => ifAuth(UserManageScreen()),
              ProductEditScreen.nameRoute: (ctx) => ifAuth(ProductEditScreen()),
              AuthScreen.nameRoute: (ctx) => AuthScreen(),
            },
          );
        },
      ),
    );
  }
}
