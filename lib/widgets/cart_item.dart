import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.deleteItem,
    @required this.addItem,
  }) : super(key: key);

  final String id;
  final String title;
  final int quantity;
  final double price;
  final Function deleteItem;
  final Function addItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: Colors.green,
        child: FittedBox(
          alignment: Alignment.centerLeft,
          child: Text(
            'ADD',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: Colors.red,
        child: FittedBox(
          alignment: Alignment.centerRight,
          child: Text(
            quantity > 1 ? 'REMOVE' : 'DELETE',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          addItem(id, price, title);
          return false;
        }
        if (direction == DismissDirection.endToStart) {
          deleteItem(id);
          if (quantity > 1) {
            return false;
          }
          return true;
        }
      },
      key: Key(id),
      child: Card(
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
      ),
    );
  }
}
