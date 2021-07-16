import 'package:hive/hive.dart';
import 'package:bill_app/models/product_model.dart';

class Boxes {
  static Box<Product> getProducts() => Hive.box<Product>('products');
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
