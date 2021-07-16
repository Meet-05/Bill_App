import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String price;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  int discount;
  Product({this.name, this.price, this.discount = 0, this.quantity = 1});
}

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String price;

  @HiveField(2)
  List<Product> productList;

  @HiveField(3)
  String time;

  @HiveField(4)
  String date;
}
