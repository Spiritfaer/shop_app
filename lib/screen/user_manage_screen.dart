import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/menu_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/manage_item.dart';
import '../screen/product_edit_screen.dart';

class UserManageScreen extends StatelessWidget {
  static const String nameRoute = '/user-manage-screen';
  static const String nameScreen = 'Manage products';

  const UserManageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider prodData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(nameScreen),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //to navigate to new product screen
                Navigator.pushNamed(context, ProductEditScreen.nameRoute);
              })
        ],
      ),
      drawer: MenuDrawer(),
      body: ListView.builder(
        itemCount: prodData.items.length,
        itemBuilder: (context, index) => ManageItme(
          title: prodData.items[index].title,
          imageUrl: prodData.items[index].imageUrl,
        ),
      ),
    );
  }
}
