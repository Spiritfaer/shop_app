import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/screen/cart_screen.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/menu_drawer.dart';
import '../providers/cart.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProtuctsOverviewScreen extends StatefulWidget {
  static const String nameRoute = '/products-overview-screen';
  static const String nameScreen = 'Prodacts overview';

  @override
  _ProtuctsOverviewScreenState createState() => _ProtuctsOverviewScreenState();
}

class _ProtuctsOverviewScreenState extends State<ProtuctsOverviewScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.nameRoute);
              },
            ),
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
