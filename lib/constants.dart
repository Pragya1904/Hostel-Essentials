import 'package:flutter/material.dart';

const kItemTextStyle=TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 17,
);
const kHeadingTextStyle=TextStyle(
  color: Colors.pink,
  fontSize: 30,
  fontWeight: FontWeight.w500,
  shadows:[Shadow(blurRadius: 10,color: Colors.grey, offset: Offset(5.0,5.0),),],
);

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