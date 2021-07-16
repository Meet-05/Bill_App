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

const kSearchBar = InputDecoration(
  contentPadding: EdgeInsets.all(10.0),
  suffix: Icon(
    Icons.search,
    size: 30.0,
    color: Colors.black,
  ),
  filled: true,
  fillColor: Colors.white,
  hintText: 'Search for Product',
  hintStyle: TextStyle(
    fontSize: 25.0,
    color: Colors.black,
  ),
  border: OutlineInputBorder(),
);
