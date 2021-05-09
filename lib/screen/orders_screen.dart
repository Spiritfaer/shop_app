import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/orders_item.dart' as wid;
import '../widgets/menu_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const String nameRoute = '/orders-screen';
  static const String nameScreen = 'Orders';

  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orders ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MenuDrawer(),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (ctx, index) {
            return wid.OrderItem(orderItem: ordersData.orders[index]);
          }),
    );
  }
}
