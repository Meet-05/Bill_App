import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:bill_app/boxes.dart';

Future addTransaction(String name, String price, List<Product> products,
    String time, String date) async {
  final transaction = Transaction()
    ..name = name
    ..price = price
    ..productList = products
    ..time = time
    ..date = date;

  final box = Boxes.getTransactions();
  box.add(transaction);
  print('transaction added suc');
}
