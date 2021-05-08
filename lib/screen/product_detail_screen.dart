import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/protuct.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String nameRoute = '/product-detail-screen';

  Widget _buildDetail(BuildContext context, Product product, Function addItem) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavorite
                        ? Theme.of(context).accentColor
                        : Colors.grey,
                    size: 30,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).accentColor,
                    child: FittedBox(
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Text(product.description),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
          child: Text('BUY NOW!'),
          onPressed: () {
            addItem(product.id, product.price, product.title);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String prodID = ModalRoute.of(context).settings.arguments as String;
    final Product product =
        Provider.of<ProductsProvider>(context, listen: false).findById(prodID);
    final Cart cartData = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: _buildDetail(
        context,
        product,
        cartData.addItem,
      ),
    );
  }
}
