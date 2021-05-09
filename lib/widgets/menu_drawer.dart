import 'package:flutter/material.dart';
import 'package:shop_app1/screen/product_detail_screen.dart';

import '../screen/products_overview_screen.dart';
import '../screen/orders_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key key}) : super(key: key);

// MyApp.defRoute: (ctx) => ProtuctsOverviewScreen(),
// ProductDetailScreen.nameRoute: (ctx) => ProductDetailScreen(),
// CartScreen.nameRoute: (ctx) => CartScreen(),

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: FittedBox(
              child: Text(
                'Shop & Shop',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text(ProtuctsOverviewScreen.nameScreen),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                ProtuctsOverviewScreen.nameRoute,
              );
            },
          ),
          ListTile(
            title: Text(OrderScreen.nameScreen),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                OrderScreen.nameRoute,
              );
            },
          ),
        ],
      ),
    );
  }
}
