import 'package:bill_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:build_daemon/constants.dart';

class TransactionDetail extends StatelessWidget {
  Transaction transaction;
  TransactionDetail({this.transaction});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${transaction.name}',
                    style: ktitleStyle.copyWith(fontSize: 50.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Text(
                      '${transaction.time}',
                      style: ktitleStyle.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0))),
                child: ListView.builder(
                    itemCount: transaction.productList.length,
                    itemBuilder: (context, index) {
                      Product product = transaction.productList[index];
                      var discounted_price = ((product.quantity *
                                  int.parse(product.price)) -
                              (product.quantity * int.parse(product.price)) *
                                  (product.discount / double.parse('100')))
                          .floor();
                      return Container(
                        margin: EdgeInsets.all(12.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${product.quantity} ${product.name}',
                                    style: ktitleStyle.copyWith(
                                        color: Colors.black, fontSize: 25),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Text(
                                    '₹ ${discounted_price}',
                                    style: ktitleStyle,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '@ ₹ ${product.price}',
                                  style: ktitleStyle,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                product.discount != 0
                                    ? Text(
                                        '${product.discount} % discount',
                                        style: ktitleStyle,
                                      )
                                    : Text('')
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: Colors.black12),
              child: Text(
                '₹ ${transaction.price}',
                style: ktitleStyle.copyWith(fontSize: 29.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
