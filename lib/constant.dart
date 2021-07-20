import 'package:flutter/material.dart';

const kinputDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(15.0),
  filled: true,
  fillColor: Colors.white,
  hintText: 'Product Name',
  hintStyle: TextStyle(
    fontSize: 25.0,
    color: Colors.black,
  ),
);

const ktitleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kCardInputDecoraction = InputDecoration(
    contentPadding: EdgeInsets.all(10.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))));
enum sheet { transaction, product }
const kSearchBar = InputDecoration(
  contentPadding: EdgeInsets.all(8.0),
  filled: true,
  fillColor: Colors.white,
  hintText: 'Search for Product',
  hintStyle: TextStyle(
    fontSize: 25.0,
    color: Colors.black,
  ),
  border: OutlineInputBorder(),
);
