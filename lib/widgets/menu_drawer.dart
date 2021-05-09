import 'package:flutter/material.dart';
import 'package:shop_app1/screen/product_detail_screen.dart';

import '../screen/products_overview_screen.dart';
import '../screen/orders_screen.dart';
import '../screen/user_manage_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key key}) : super(key: key);

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
            leading: Icon(Icons.shop),
            title: Text(ProtuctsOverviewScreen.nameScreen),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                ProtuctsOverviewScreen.nameRoute,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(OrderScreen.nameScreen),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                OrderScreen.nameRoute,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(UserManageScreen.nameScreen),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                UserManageScreen.nameRoute,
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
