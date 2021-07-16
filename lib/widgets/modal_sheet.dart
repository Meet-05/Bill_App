import 'package:flutter/material.dart';
import 'package:bill_app/constant.dart';
import 'package:provider/provider.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:bill_app/providers/product_provider.dart';
import 'package:bill_app/providers/product_operations.dart';

class ModalSheet extends StatefulWidget {
  final Product product;
  ModalSheet({this.product});
  @override
  _ModalSheetState createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String price;
  Product product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.product != null) {
      product = widget.product;
      name = product.name;
      price = product.price;
    }
  }

  void onTap() {
    print('tapped');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.product == null
          ? addProduct(name, price)
          : editProduct(product, name, price);
      print('product aded');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //provider = Provider.of<ProductProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.48,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Text(
                  'Add New Product',
                  style: ktitleStyle,
                )),
                SizedBox(height: 20.0),
                TextFormField(
                    initialValue: name,
                    validator: (value) {
                      if (value.isNotEmpty) {
                        return null;
                      }
                      return 'please enter name';
                    },
                    onSaved: (value) {
                      name = value;
                    },
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                    decoration: kinputDecoration.copyWith(
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        borderRadius: new BorderRadius.circular(20.7),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    initialValue: price,
                    validator: (value) {
                      if (value.isNotEmpty && int.tryParse(value) != null) {
                        return null;
                      }
                      return 'please enter price';
                    },
                    onSaved: (value) {
                      price = value;
                    },
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                    decoration: kinputDecoration.copyWith(
                      hintText: 'Price',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        borderRadius: new BorderRadius.circular(20.7),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      onTap();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        widget.product == null ? 'Add Product' : 'Edit Product',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
