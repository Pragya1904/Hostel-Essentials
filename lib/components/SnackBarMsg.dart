import 'package:flutter/material.dart';

class SnackBarMsg{
  static const successLoginSB=SnackBar(content: Text("Login Successful"),
  backgroundColor: Colors.green,);

  static const successSignUpSnackBar = SnackBar(
    content: Text('Account Created Successful'),
    backgroundColor: Colors.green,
  );

  static const errorSnackBar = SnackBar(
    content: Text('Error occurred please try again'),
    backgroundColor: Colors.red,
  );
}