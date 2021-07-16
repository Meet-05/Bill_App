import 'customer.dart';
import 'supplier.dart';

class Invoice {
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    this.supplier,
    this.customer,
    this.items,
  });
}

class InvoiceItem {
  final String description;
  final String time;
  final int quantity;
  final int price;
  final int discount;
  final int total_price;

  const InvoiceItem(
      {this.description,
      this.time,
      this.quantity,
      this.price,
      this.discount,
      this.total_price});
}
