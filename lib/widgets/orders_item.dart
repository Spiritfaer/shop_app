import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key,
    @required this.orderItem,
  }) : super(key: key);

  final ord.OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    // orderItem.products;
    // orderItem.id;
    // orderItem.amount;
    // orderItem.dateTime;

    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${orderItem.amount}',
            ),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
