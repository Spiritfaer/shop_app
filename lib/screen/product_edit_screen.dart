import 'package:flutter/material.dart';
import 'package:shop_app1/providers/protuct.dart';

class ProductEditScreen extends StatefulWidget {
  static const String nameRoute = '/product-edit-screen';
  static const String nameScreen = 'Edit product\'s detail';

  const ProductEditScreen({Key key}) : super(key: key);

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocuNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Product _editedProduct = Product.empty();

  @override
  void initState() {
    _imageUrlFocuNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocuNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocuNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocuNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    print(_editedProduct.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductEditScreen.nameScreen),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (newValue) {
                    _editedProduct = _editedProduct.copyWith(title: newValue);
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Wrong value';
                      }
                      if (double.tryParse(value) <= 0) {
                        return 'Price shout be more then 0';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (newValue) {
                      _editedProduct = _editedProduct.copyWith(
                        price: double.parse(newValue),
                      );
                    }),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    if (value.length < 10) {
                      return 'That description so short!';
                    }
                    return null;
                  },
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  onSaved: (newValue) {
                    _editedProduct =
                        _editedProduct.copyWith(description: newValue);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Center(
                                child: Text(
                                  'Enter a URL',
                                ),
                              )
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
                                fit: BoxFit.cover,
                              )),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value';
                          }
                          if (!value.startsWith('http://') &&
                              !value.startsWith('https://')) {
                            return 'Please enter a valid URL';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jepg')) {
                            return 'Please enter a valid image';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocuNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (newValue) {
                          _editedProduct =
                              _editedProduct.copyWith(imageUrl: newValue);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
