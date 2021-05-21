import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/protuct.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String nameRoute = '/product-detail-screen';
  static const String nameScreen = 'Prodact details';

  Widget _buildDetail(BuildContext context, Product product, Function addItem) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 16,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                shadows: [
                  Shadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 2.5,
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
            ),
            background: Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
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
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(product.description),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor),
                  child: Text('BUY NOW!'),
                  onPressed: () {
                    addItem(product.id, product.price, product.title);
                  },
                ),
              ),
            ],
          ),
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
      body: _buildDetail(
        context,
        product,
        cartData.addItem,
      ),
    );
  }
}
