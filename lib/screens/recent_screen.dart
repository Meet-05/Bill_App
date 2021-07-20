import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bill_app/boxes.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:bill_app/constant.dart';
import 'transaction_detail.dart';
import 'package:bill_app/widgets/transaction_card.dart';

class RecentScreen extends StatefulWidget {
  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: TextField(
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              decoration: kSearchBar.copyWith(
                hintText: 'Enter Customer Name',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(20.7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(20.7),
                ),
              ),
              onChanged: (value) {
                searchText = value.toLowerCase();

                setState(() {});
              },
            ),
          ),
          ValueListenableBuilder<Box<Transaction>>(
            valueListenable: Boxes.getTransactions().listenable(),
            builder: (context, box, _) {
              List<Transaction> transactions =
                  box.values.toList().cast<Transaction>();
              transactions = transactions
                  .where((element) =>
                      element.name.toLowerCase().contains(searchText))
                  .toList();

              print(transactions.length);
              return Expanded(
                  child: ListView.builder(
                      itemCount:
                          transactions.length < 25 ? transactions.length : 25,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                          transaction:
                              transactions[(transactions.length - 1) - index],
                        );
                      }));
            },
          )
        ],
      ),
    )));
  }
}
