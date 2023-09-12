import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({super.key});
  static const routeName = '/edit-product';
  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _pricefocusNode = FocusNode();
  final _descriptionfocusNode = FocusNode();
  final _imageurlcontroller = TextEditingController();
  final _imageurlfocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Product _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _init = true;

  @override
  void initState() {
    _imageurlfocusNode.addListener(_updateURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final String? productId =
        ModalRoute.of(context)?.settings.arguments as String?;
    print(productId);
    if (_init) {
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageurlcontroller.text = _editedProduct.imageUrl;
      }
    }
    _init = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final _isValid = _form.currentState!.validate();
    if (_isValid) {
      if (_editedProduct.id?.isNotEmpty != null) {
        // print(_editedProduct.title);
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id as String, _editedProduct);
        print(_editedProduct.title);
      } else {
        Provider.of<Products>(context, listen: false)
            .addProducts(_editedProduct);
      }

      _form.currentState!.save();
      Navigator.of(context).pop();
    }
  }

  void _updateURL() {
    if (_imageurlfocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _pricefocusNode.dispose();
    _descriptionfocusNode.dispose();
    _imageurlcontroller.dispose();
    _imageurlfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: [
            IconButton(
              onPressed: _saveForm,
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_pricefocusNode),
                  onChanged: (value) {
                    // print(value);
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        isFavourite: _editedProduct.isFavourite,
                        title: value as String,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Provide a Value';
                    }
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _pricefocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionfocusNode),
                  onChanged: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value as String),
                        imageUrl: _editedProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Provide a Value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a number.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than 0';
                    }
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionfocusNode,
                  onChanged: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        isFavourite: _editedProduct.isFavourite,
                        title: _editedProduct.title,
                        description: value as String,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, left: 4),
                      decoration: BoxDecoration(border: Border.all()),
                      child: _imageurlcontroller.text.isEmpty
                          ? Text('Enter URL')
                          : FittedBox(
                              child: Image.network(
                                _imageurlcontroller.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        controller: _imageurlcontroller,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageurlfocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onChanged: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavourite: _editedProduct.isFavourite,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value as String);
                        },
                        validator: (value) {
                          if (!value!.startsWith('http') ||
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL.';
                          }
                          if (!value.endsWith('.jpg') &&
                              !value.endsWith('.png') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid Image';
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}
