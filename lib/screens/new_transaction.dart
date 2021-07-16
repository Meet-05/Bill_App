import 'package:bill_app/providers/transaction_operations.dart';
import 'package:flutter/material.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:bill_app/widgets/search_product.dart';
import 'package:bill_app/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:bill_app/constant.dart';
import 'package:intl/intl.dart';
import 'package:bill_app/models/customer.dart';
import 'package:bill_app/models/invoice.dart';
import 'package:bill_app/models/supplier.dart';
import 'package:pdf/pdf.dart';
import 'package:bill_app/api/pdf_api.dart';
import 'package:bill_app/api/pdf_invoice_api.dart';
import 'package:bill_app/api/UserSheetApi.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SearchProduct(),
            DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.8,
                builder: (context, controller) => BillContainer(
                      c: controller,
                    ))
          ],
        ),
      ),
    );
  }
}

class BillContainer extends StatefulWidget {
  final ScrollController c;

  BillContainer({this.c});

  @override
  _BillContainerState createState() => _BillContainerState();
}

class _BillContainerState extends State<BillContainer> {
  final _formKey = GlobalKey<FormState>();
  String name;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      // height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFF605c5c),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Column(
        children: [
          Text(
            'Bill',
            style: ktitleStyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          // Consumer<ProductProvider>(builder: (context, provider, child) {
          //return
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextFormField(
                  style:
                      ktitleStyle.copyWith(color: Colors.black, fontSize: 30.0),
                  validator: (String value) {
                    if (value.isNotEmpty) {
                      return null;
                    }
                    return 'name is Null';
                  },
                  decoration: kinputDecoration.copyWith(
                    hintText: 'Enter name',
                  ),
                  onSaved: (String value) {
                    name = value;
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: widget.c,
                itemCount: provider.productList.length,
                itemBuilder: (context, index) {
                  Product product = provider.productList[index];
                  print('quantity is ->${product.quantity}');

                  var discounted_price =
                      ((product.quantity * int.parse(product.price)) -
                              (product.quantity * int.parse(product.price)) *
                                  (product.discount / double.parse('100')))
                          .floor();
                  print('$discounted_price');

                  final _formKey = GlobalKey<FormState>();

                  return Dismissible(
                    key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                    background: Container(
                      margin: EdgeInsets.all(8.0),
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        size: 50.0,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    onDismissed: (_) {
                      provider.deleteItem(index);
                    },
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (_) {
                      return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text(
                                    'Do you want to permanantely delete this?'),
                                actions: [
                                  TextButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop(true);
                                      }),
                                  TextButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop(false);
                                      }),
                                ],
                              ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.only(
                          bottom: 5.0, top: 12.0, left: 12.0, right: 12.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${product.name}',
                                  style: ktitleStyle.copyWith(fontSize: 25),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Counter(
                                      text: '${product.quantity}',
                                      onDown: () {
                                        product.quantity -= 1;
                                        Provider.of<ProductProvider>(context,
                                                listen: false)
                                            .updateItem(index, product);
                                      },
                                      onUp: () {
                                        product.quantity += 1;
                                        Provider.of<ProductProvider>(context,
                                                listen: false)
                                            .updateItem(index, product);
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'x',
                                      style:
                                          ktitleStyle.copyWith(fontSize: 15.0),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      '${product.price}',
                                      style:
                                          ktitleStyle.copyWith(fontSize: 30.0),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Counter(
                                      text: '${product.discount}',
                                      onDown: () {
                                        product.discount -= 1;
                                        Provider.of<ProductProvider>(context,
                                                listen: false)
                                            .updateItem(index, product);
                                      },
                                      onUp: () {
                                        product.discount += 1;
                                        Provider.of<ProductProvider>(context,
                                                listen: false)
                                            .updateItem(index, product);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  "₹ $discounted_price",
                                  style: ktitleStyle.copyWith(fontSize: 20.0),

                                  //'${((product.discount / int.parse(product.price) * product.quantity) * 100).floor()}',
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          // ;})
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                String formattedDateTime =
                    DateFormat.yMMMMd().format(DateTime.now());
                // String formattedDateTime =
                //    DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
                String hours = DateFormat('hh:mm a').format(DateTime.now());
                addTransaction(name, '${provider.total}', provider.productList,
                    "$hours, $formattedDateTime", "$formattedDateTime");
                final invoice = Invoice(
                    supplier: Supplier(name: 'SHRIJI HARDWARE'),
                    customer: Customer(name: name),
                    items: provider.productList
                        .map((product) => InvoiceItem(
                            description: product.name,
                            time: "$hours,$formattedDateTime",
                            quantity: product.quantity,
                            price: int.parse(product.price),
                            discount: product.discount,
                            total_price:
                                ((product.quantity * int.parse(product.price)) -
                                        (product.quantity *
                                                int.parse(product.price)) *
                                            (product.discount /
                                                double.parse('100')))
                                    .floor()))
                        .toList());

                final pdfFile = await PdfInvoiceApi.generate(invoice);

                Navigator.pop(context);
                PdfApi.openFile(pdfFile);

                UserSheetApi.insertData(provider.productList
                    .map((e) => {
                          "Product": e.name,
                          "Quantity": '${e.quantity}',
                          "Price": e.price,
                          "discount%": '${e.discount}',
                          "Total":
                              '${((e.quantity * int.parse(e.price)) - (e.quantity * int.parse(e.price)) * (e.discount / double.parse('100'))).floor()}',
                          "Time": "$hours,$formattedDateTime",
                          "name": name
                        })
                    .toList());
                provider.restProvider();
              }
            },
            child: Container(
              padding: EdgeInsets.all(20.0),
              // margin: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(color: Colors.black12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '₹ ${provider.total}',
                    style: ktitleStyle.copyWith(fontSize: 29.0),
                  ),
                  Icon(Icons.print)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  Function onUp;
  Function onDown;
  String text;

  Counter({this.text, this.onDown, this.onUp});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_drop_up,
              ),
              onPressed: onUp),
          Text(
            text,
            style: ktitleStyle.copyWith(fontSize: 25.0),
          ),
          IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: onDown),
        ],
      ),
    );
  }
}
