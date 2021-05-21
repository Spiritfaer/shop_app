import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/screen/auth_screen.dart';

import '../providers/auth.dart';
import '../helpers/custom_route.dart';
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
              Navigator.pushReplacementNamed(context, OrderScreen.nameRoute);
              // Navigator.of(context).pushReplacement(
              //     CustomRoute(builder: (ctx) => OrderScreen()));
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
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacementNamed(context, AuthScreen.nameRoute);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
