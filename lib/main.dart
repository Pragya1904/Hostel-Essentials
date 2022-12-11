import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/screens/cart_screen.dart';
import 'package:hostel_essentials/screens/home_screen.dart';
import 'package:hostel_essentials/screens/login_screen.dart';
import 'package:hostel_essentials/screens/signup_screen.dart';
import 'screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Essentric());
}

class Essentric extends StatelessWidget {
  const Essentric({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch:  Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id: (context)=>WelcomeScreen(),
        HomeScreen.id:(context)=> HomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        SignUpScreen.id:(context)=>SignUpScreen(),
        CartScreen.id:(context)=>CartScreen(),
      },
    );
  }
}
