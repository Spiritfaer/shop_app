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
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: Theme.of(context).errorColor,
        child: FittedBox(
          alignment: Alignment.centerRight,
          child: quantity > 1
              ? Icon(
                  Icons.remove,
                  color: Colors.white,
                )
              : Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          addItem(id, price, title);
          return false;
        }
        if (direction == DismissDirection.endToStart) {
          if (quantity > 1) {
            deleteItem(id);
            return false;
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to remove the item from the cart?'),
                actions: [
                  TextButton(
                    child: Text('Yes'),
                    onPressed: () {
                      deleteItem(id);
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  )
                ],
              ),
            );
          }
        }
        return false;
      },
      key: Key(id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: ListTile(
          title: Text(title),
          trailing: Chip(
            backgroundColor: Theme.of(context).primaryColor,
            label: Text(
              '\$${(price * quantity).toStringAsFixed(2)}',
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
