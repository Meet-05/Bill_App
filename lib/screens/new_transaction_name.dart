// import 'package:flutter/material.dart';
// import 'package:bill_app/screens/new_transaction.dart';
// import 'package:bill_app/constant.dart';

// class NewTransactionName extends StatefulWidget {
//   @override
//   _NewTransactionNameState createState() => _NewTransactionNameState();
// }

// class _NewTransactionNameState extends State<NewTransactionName> {
//   final _formKey = GlobalKey<FormState>();
//   String name;
//   onSaved() {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => NewTransaction()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Center(
//                   child: TextFormField(
//                     style: ktitleStyle.copyWith(
//                         color: Colors.black, fontSize: 30.0),
//                     validator: (String value) {
//                       if (value.isNotEmpty) {
//                         return null;
//                       }
//                       return 'name is Null';
//                     },
//                     decoration: kinputDecoration.copyWith(
//                       hintText: 'Enter name',
//                     ),
//                     onSaved: (String value) {
//                       name = value;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               MaterialButton(
//                 onPressed: onSaved,
//                 child: Container(
//                   // margin: EdgeInsets.all(10.0),
//                   padding: EdgeInsets.all(20.0),
//                   child: Text(
//                     'Next',
//                     style: ktitleStyle,
//                   ),
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
