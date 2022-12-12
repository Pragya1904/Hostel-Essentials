import 'dart:developer';
import 'package:hostel_essentials/components/SnackBarMsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/constants.dart';
import 'package:hostel_essentials/screens/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/RoundedButton.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey=GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late SharedPreferences loginData;
  late User loggedInUser;
  bool showSpinner=false;
  bool newUser=false;
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  @override
  void initState() {
    getCurrentUser();
    super.initState();
    isLoggedIn();
  }
  void isLoggedIn() async{
    loginData=await SharedPreferences.getInstance();
    newUser=(loginData.getBool('Login')??true);
    if(newUser==false)
    {
      Navigator.pushNamed(context, HomeScreen.id);
    }
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
        child: Form(
          key: _formkey,
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: emailController,
                  validator:(value){
                    if(value==null||value.isEmpty)
                    {
                      return "Please Enter Some Text";
                    }
                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]").hasMatch(value)){
                      return "Please enter a valid email";
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    emailController.text=value!;},
                  style:kButtonTextStyle,
                  decoration: kTextFieldDecoration.copyWith(hintText: "enter your email ID",labelText: "Email ID"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  controller: passwordController,
                  validator:(value){
                    if(value==null||value.isEmpty)
                    {
                      return "Please Enter Some Text";
                    }
                    else{
                      return null;}
                  },
                  onSaved: (value) {
                    passwordController.text=value!;
                  },
                  style: kButtonTextStyle,
                  decoration:kTextFieldDecoration.copyWith(hintText: "enter your password",labelText: "Password"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                RoundedButton1(onPressed: () async{
                  setState(() {
                    showSpinner=true;
                  });
                  final user=await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                  try{
                    if(_formkey.currentState!.validate())
                    {
                      SnackBarMsg.successLoginSB;
                      loginData.setBool('login', false);
                      loginData.setString('email', emailController.text);
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
      ),
    );
  }
}
