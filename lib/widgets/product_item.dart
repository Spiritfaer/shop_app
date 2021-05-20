import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/product_detail_screen.dart';
import '../providers/protuct.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product prod = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final Auth auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetailScreen.nameRoute,
            arguments: prod.id,
          ),
          child: Image.network(
            prod.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: product.isFavorite
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              ),
              onPressed: () {
                product.toggleFavoriteStatus(auth.token, auth.user);
              },
            ),
          ),
          backgroundColor: Colors.black87,
          title: FittedBox(
            child: Text(
              prod.title,
              textAlign: TextAlign.center,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 18,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItem(prod.id, prod.price, prod.title);
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to the cart',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.deleteLastItem();
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
