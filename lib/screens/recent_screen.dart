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
                fontSize: 25.0,
                color: Colors.black,
              ),
              decoration: kSearchBar.copyWith(
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
                searchText = value;

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
                  .where((element) => element.name.contains(searchText))
                  .toList();
              print(transactions.length);
              return Expanded(
                  child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                          transaction: transactions[index],
                        );
                      }));
            },
          )
        ],
      ),
    )));
  }
}

// class TransactionCard extends StatelessWidget {
//   Transaction transaction;
//   TransactionCard({this.transaction});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => TransactionDetail(
//                       transaction: transaction,
//                     )));
//       },
//       child: Container(
//         padding: EdgeInsets.all(12.0),
//         margin: EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//             color: Colors.blue[300],
//             borderRadius: BorderRadius.all(Radius.circular(20.0))),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '${transaction.name}',
//                   style: ktitleStyle.copyWith(
//                       fontSize: 25.0, color: Colors.black, letterSpacing: 0.3),
//                 ),
//                 Container(
//                     padding: EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.all(Radius.circular(12.0))),
//                     child: Text(
//                       '₹ ${transaction.price}',
//                       style: ktitleStyle,
//                     ))
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(Icons.date_range),
//                 SizedBox(
//                   width: 20.0,
//                 ),
//                 Text('${transaction.time}',
//                     style: ktitleStyle.copyWith(
//                       fontSize: 15.0,
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
