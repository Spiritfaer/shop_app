import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/product_item.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key key,
    @required this.orderItem,
  }) : super(key: key);

  final ord.OrderItem orderItem;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final prods = widget.orderItem.products;
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.orderItem.amount}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: min(prods.length * 20.0 + 10.0, 100.0),
              child: ListView.builder(
                itemCount: prods.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${prods[index].title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${prods[index].quantity} x ${prods[index].price}',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
