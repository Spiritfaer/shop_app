import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  }) : super(key: key);

  final String id;
  final String title;
  final int quantity;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: ListTile(
        title: Text(title),
        trailing: Chip(
          backgroundColor: Theme.of(context).primaryColor,
          label: Text(
            '\$${price * quantity}',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1.color,
            ),
          ),
        ),
        subtitle: Text('quantity: $quantity | cost: $price'),
      ),
    );
  }
}
