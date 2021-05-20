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
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MenuDrawer(),
      body: FutureBuilder(
        future:
            Provider.of<Orders>(context, listen: false).fetchAndSetorders(true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            //TODO error handling stuff
            return Center(
              child: Text('Some error!'),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, ordersData, child) => ListView.builder(
                itemCount: ordersData.orders.length,
                itemBuilder: (ctx, index) =>
                    wid.OrderItem(orderItem: ordersData.orders[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
