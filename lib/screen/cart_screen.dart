import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../providers/cart.dart' hide CartItem;
import '../widgets/cart_item.dart';

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
                      '\$${cartData.itemSum.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  _OrdersButton(cartData: cartData),
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
              return CartItem(
                id: cartItems[key].id,
                title: cartItems[key].title,
                quantity: cartItems[key].quantity,
                price: cartItems[key].price,
                deleteItem: cartData.deleteItem,
                addItem: cartData.addItem,
              );
            },
            itemCount: cartData.items.length,
          ))
        ],
      ),
    );
  }
}

class _OrdersButton extends StatefulWidget {
  const _OrdersButton({
    Key key,
    @required this.cartData,
  }) : super(key: key);

  final Cart cartData;

  @override
  __OrdersButtonState createState() => __OrdersButtonState();
}

class __OrdersButtonState extends State<_OrdersButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cartData.itemSum <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cartData.items.values.toList(),
                  widget.cartData.itemSum);
              setState(() {
                _isLoading = false;
              });
              widget.cartData.clearCart();
              Navigator.pop(context);
            },
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW!'),
    );
  }
}
