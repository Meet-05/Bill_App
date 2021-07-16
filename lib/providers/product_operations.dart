import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:bill_app/boxes.dart';

Future addProduct(String name, String price) async {
  final product = Product()
    ..name = name
    ..price = price;
  final box = Boxes.getProducts();
  box.add(product);
}

void editProduct(Product product, String name, String price) {
  product.name = name;
  product.price = price;
  product.save();
}

void delete(Product product) {
  product.delete();
}
