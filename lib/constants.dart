import 'package:flutter/material.dart';


const kTextFieldDecoration=InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.grey),
  labelText: "Email ID",
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Color(0xfff2385f), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Color(0xfff2385f), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kButtonTextStyle=TextStyle(
  color: Colors.black,
);