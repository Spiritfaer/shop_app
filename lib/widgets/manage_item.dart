import 'package:flutter/material.dart';

import '../screen/product_edit_screen.dart';

class ManageItme extends StatelessWidget {
  const ManageItme({
    Key key,
    @required this.title,
    @required this.imageUrl,
    @required this.deleteItem,
    this.id,
  }) : super(key: key);

  final String id;
  final String title;
  final String imageUrl;
  final Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).primaryColor,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProductEditScreen.nameRoute,
                      arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are you sure?'),
                      content:
                          Text('Do you want to delete the product at all?!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            deleteItem(id);
                            print('Yes');
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            print('No');
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
