import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/components/SnackBarMsg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hostel_essentials/screens/home_screen.dart';
import '../components/RoundedButton.dart';
import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
static const String id='signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;
  final _auth=FirebaseAuth.instance;
  final _formkey=GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  bool showSpinner=false;
  bool validatePassword(String pass)
  {
    String _password=pass.trim();
    if(_password.isEmpty)
    {
      setState(() {
        password_strength=0.0;
      });
    }
    else if(_password.length<6)
    {
      setState(() {
        password_strength=1/4;
      });
    }
    else if(_password.length<8) {
      setState(() {
        password_strength = 2 / 4;
      });
    }
    else if(_password.length>=8)
    {
      if(pass_valid.hasMatch( _password))
      {
        setState(() {
          password_strength=1;
        });
        return true;
      }
      else
      {
        setState(() {
          password_strength=3/4;
        });
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall:showSpinner ,
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag:'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
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
                  style: kButtonTextStyle,
                  decoration: kTextFieldDecoration.copyWith(hintText: "enter email ID",labelText: "Email ID"),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  controller: passwordController,
                  validator:(value){
                    if(value==null||value.isEmpty)
                    {
                      return "Please Enter Some Text";
                    }
                    else{
                      bool result=validatePassword(value);
                      if(result)
                        return null;
                      else
                        return "Try a stronger password \n 1. minimum length 6 \n 2. Mix of Upper case,lower case and special characters";
                    }
                  },
                  onSaved: (value) {
                    passwordController.text=value!;
                  },
                  style: kButtonTextStyle,
                  decoration: kTextFieldDecoration.copyWith(hintText: "enter your password",labelText: "Password"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: LinearProgressIndicator(
                    value: password_strength,
                    minHeight: 5,
                    color: password_strength<=1/4?Colors.red:password_strength==2/4?Colors.yellow:password_strength==3/4?Colors.blue:Colors.green,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                RoundedButton1(
                  onPressed: () async{
                    setState(() {
                      // showSpinner=true;
                    });
                    try{
                      if(_formkey.currentState!.validate())
                      {
                        if( password_strength==1)
                        {
                          setState(() {
                            showSpinner=true;
                          });
                          final newUser=   await _auth.createUserWithEmailAndPassword(email: emailController.text, password:passwordController.text);
                          SnackBarMsg.successSignUpSnackBar;
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                      }

                      setState(() {
                        showSpinner=false;
                      });
                    }
                    catch(e){
                      if (kDebugMode)
                        {
                          print("User Not Created");
                        }

                    }

                  },
                  title1: "Register",
                  colour: Colors.blueAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
