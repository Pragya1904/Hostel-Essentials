import 'dart:developer';
import 'package:hostel_essentials/components/SnackBarMsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/constants.dart';
import 'package:hostel_essentials/screens/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/RoundedButton.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  bool showSpinner=false;
  String password='';
  String email='';
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
  void getCurrentUser()async{
    try{
      final user=await _auth.currentUser;
      if(user!=null) {
        loggedInUser=user;
      }
    }
    catch(e)
    {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                style:kButtonTextStyle,
                decoration: kTextFieldDecoration.copyWith(hintText: "enter your email ID",labelText: "Email ID"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password=value;
                },
                style: kButtonTextStyle,
                decoration:kTextFieldDecoration.copyWith(hintText: "enter your password",labelText: "Password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton1(onPressed: () async{
                setState(() {
                  showSpinner=true;
                });
                final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                try{
                  if(user!=null)
                  {
                    SnackBarMsg.successLoginSB;
                    Navigator.pushNamed(context, HomeScreen.id);
                  }
                  else
                  {
                    SnackBarMsg.errorSnackBar;
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e)
                {
                  if (kDebugMode) {
                    print("Invalid user");
                  }
                }
              },
                  title1: "Log in",
                  colour: Colors.pink,)
            ],
          ),
        ),
      ),
    );
  }
}
