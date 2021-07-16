import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:bill_app/providers/product_provider.dart';
import 'package:bill_app/widgets/modal_sheet.dart';
import 'package:bill_app/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bill_app/constant.dart';
import 'package:bill_app/providers/product_operations.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: TextField(
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  suffix: Icon(
                    Icons.search,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search for Product',
                  hintStyle: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(20.7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(20.7),
                  )),
              onChanged: (value) {
                searchText = value;
                setState(() {});
              },
            ),
          ),
          ValueListenableBuilder<Box<Product>>(
              valueListenable: Boxes.getProducts().listenable(),
              builder: (context, box, _) {
                List<Product> products = box.values.toList().cast<Product>();
                products = products
                    .where((element) => element.name.contains(searchText))
                    .toList();

                return Expanded(
                  child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        var product = products[index];
                        print(product.name);
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListTile(
                            onTap: () {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .addProduct(product);
                            },
                            title: Text(
                              product.name,
                              style: ktitleStyle.copyWith(
                                  color: Colors.black, fontSize: 25.0),
                            ),
                            trailing: Chip(
                                label: Text('₹ ${product.price}',
                                    style:
                                        ktitleStyle.copyWith(fontSize: 25.0))),
                          ),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
