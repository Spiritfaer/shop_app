import 'package:flutter/material.dart';

import '../screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.id,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => ProductDetailScreen(
                        title: title,
                      ))),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              size: 18,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.black87,
          title: FittedBox(
            //resizing text depends o free space
            child: Text(
              title,
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
