import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_item.dart' as CItem;

class CartScreen extends StatelessWidget {
  static const String nameRoute = '/cart-screen';
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cartData = Provider.of<Cart>(context);
    final cartItems = cartData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 12),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartData.itemSum}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('ORDER NOW!'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) {
              String key = cartItems.keys.elementAt(index);
              return CItem.CartItem(
                  id: cartItems[key].id,
                  title: cartItems[key].title,
                  quantity: cartItems[key].quantity,
                  price: cartItems[key].price);
            },
            itemCount: cartData.items.length,
          ))
        ],
      ),
    );
  }
}