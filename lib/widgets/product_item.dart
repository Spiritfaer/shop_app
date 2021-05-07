import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/product_detail_screen.dart';
import '../providers/protuct.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product prod = Provider.of<Product>(context, listen: false);

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
            builder: (context, prodact, _) => IconButton(
              icon: Icon(
                prodact.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: prodact.isFavorite
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              ),
              onPressed: () {
                prodact.toggleFavoriteStatus();
              },
            ),
          ),
          backgroundColor: Colors.black87,
          title: FittedBox(
            //resizing text depends o free space
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
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
