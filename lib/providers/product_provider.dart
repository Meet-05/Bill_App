import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:bill_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _productList = [];
  List get productList => _productList;
  var box;
  int total = 0;

  bool checkIfExists(Product product) {
    bool exists = false;
    for (Product p in _productList) {
      if (p.name == product.name) {
        exists = true;
        break;
      }
    }
    return exists;
  }

  addProduct(Product product) async {
    if (!checkIfExists(product)) {
      _productList.add(product);
      print('product added');
      getSum();
      notifyListeners();
    }
  }

  updateItem(int index, Product product) {
    _productList[index] = product;
    getSum();
    notifyListeners();
  }

  deleteItem(int index) {
    _productList.removeAt(index);
    getSum();
    notifyListeners();
  }

  restProvider() {
    _productList = [];
    notifyListeners();
  }

  getSum() {
    total = 0;

    _productList.forEach((product) {
      print('element price is ${product.price}');
      total = total +
          ((product.quantity * int.parse(product.price)) -
                  (product.quantity * int.parse(product.price)) *
                      (product.discount / double.parse('100')))
              .floor();
    });

    print('----------${total}');
  }
}
