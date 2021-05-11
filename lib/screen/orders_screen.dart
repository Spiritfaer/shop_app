import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/orders_item.dart' as wid;
import '../widgets/menu_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const String nameRoute = '/orders-screen';
  static const String nameScreen = 'Orders';

  const OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading = false;

  Future<void> _refreshProductList(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetorders();
  }

  bool isStart = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isStart) {
      setState(() {
        _isLoading = true;
      });
      _refreshProductList(context);
      setState(() {
        _isLoading = false;
      });
      isStart = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Orders ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MenuDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true;
          });
          _refreshProductList(context);
          setState(() {
            _isLoading = false;
          });
        },
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: ordersData.orders.length,
                itemBuilder: (ctx, index) {
                  return wid.OrderItem(orderItem: ordersData.orders[index]);
                }),
      ),
    );
  }
}
