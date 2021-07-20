import 'dart:async';

import 'package:bill_app/screens/recent_screen.dart';
import 'package:flutter/material.dart';
import 'package:bill_app/providers/product_provider.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:bill_app/screens/manage_products_screen.dart';
import 'package:bill_app/screens/new_transaction.dart';
import 'package:bill_app/widgets/transaction_card.dart';
import 'package:bill_app/boxes.dart';
import 'package:hive/hive.dart';
import 'package:bill_app/models/product_model.dart';
import 'package:bill_app/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int calculateSum(List<Transaction> transacionList) {
    int total = 0;
    String formattedDateTime = DateFormat.yMMMMd().format(DateTime.now());
    print(formattedDateTime);
    print(transacionList[transacionList.length - 1].time);
    for (int iterator = transacionList.length - 1; iterator >= 0; iterator--) {
      if (transacionList[iterator].date == formattedDateTime) {
        total += int.parse(transacionList[iterator].price);
        // print('------>${total}');
      } else {
        print('hyw');
        break;
      }
    }
    print(total);
    return total;
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Today's Earning",
                  style: ktitleStyle,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: ValueListenableBuilder<Box<Transaction>>(
                  valueListenable: Boxes.getTransactions().listenable(),
                  builder: (context, box, _) {
                    List<Transaction> transactions =
                        box.values.toList().cast<Transaction>();

                    return Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        transactions.length == 0
                            ? '₹ 0'
                            : '₹ ${calculateSum(transactions)}',
                        style: ktitleStyle.copyWith(fontSize: 36.0),
                      ),
                    );
                  },
                ),
              ),
              ValueListenableBuilder<Box<Transaction>>(
                  valueListenable: Boxes.getTransactions().listenable(),
                  builder: (context, box, _) {
                    List<Transaction> transactions =
                        box.values.toList().cast<Transaction>();

                    if (transactions.length == 0) {
                      return SizedBox(
                        height: 20.0,
                      );
                    } else {
                      return Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Center(
                            child: Text(
                              'Recent Transaction',
                              style: ktitleStyle,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: TransactionCard(
                                    transaction:
                                        transactions[transactions.length - 1],
                                  )),
                              Expanded(
                                flex: 1,
                                child: transactions.length == 0
                                    ? SizedBox(
                                        width: 10.0,
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: 50.0,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecentScreen()));
                                        }),
                              )
                            ],
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 70.0,
              ),
              Center(
                  child: CustomButton(
                text: 'Manage Product',
                handleTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageProductsScreen(),
                      ));
                },
              )),
              SizedBox(
                height: 30.0,
              ),
              Center(
                  child: CustomButton(
                text: 'Add new transaction',
                handleTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewTransaction(),
                      ));
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function handleTap;
  CustomButton({this.text, this.handleTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: ktitleStyle,
        ),
      ),
    );
  }
}
