import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/cart_provider.dart';
import 'package:hostel_essentials/screens/cart_screen.dart';
import 'package:hostel_essentials/screens/home_screen.dart';
import 'package:hostel_essentials/screens/loading_screen.dart';
import 'package:hostel_essentials/screens/login_screen.dart';
import 'package:hostel_essentials/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth=FirebaseAuth.instance;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Essentric());
}

class Essentric extends StatelessWidget {
  const Essentric({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(_)=>CartProvider(),
    child: Builder(builder: (BuildContext context){
      return MaterialApp(
        theme: ThemeData(
          primarySwatch:  Colors.pink,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: auth.currentUser==null?WelcomeScreen.id: LoadingScreen.id,
        routes:{
          LoadingScreen.id:(context)=>LoadingScreen(),
          WelcomeScreen.id: (context)=>WelcomeScreen(),
          HomeScreen.id:(context)=> HomeScreen(),
          LoginScreen.id:(context)=>LoginScreen(),
          SignUpScreen.id:(context)=>SignUpScreen(),
          CartScreen.id:(context)=>CartScreen(),
        },
      );
    },
    ),
    );
  }
}
