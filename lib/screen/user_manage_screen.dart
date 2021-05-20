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

  Future<void> _refreshProductList(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProductsData(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameScreen),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, ProductEditScreen.nameRoute);
              })
        ],
      ),
      drawer: MenuDrawer(),
      body: FutureBuilder(
        future: Provider.of<ProductsProvider>(context, listen: false)
            .fetchProductsData(true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<ProductsProvider>(
              builder: (context, prodData, child) => RefreshIndicator(
                onRefresh: () => _refreshProductList(context),
                child: ListView.builder(
                  itemCount: prodData.items.length,
                  itemBuilder: (context, index) => ManageItme(
                    id: prodData.items[index].id,
                    title: prodData.items[index].title,
                    imageUrl: prodData.items[index].imageUrl,
                    deleteItem: prodData.deleteById,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
