import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/provider/cart_provider.dart';
import 'package:hostel_essentials/components/Items.dart';
import 'package:hostel_essentials/constants.dart';
import 'package:hostel_essentials/screens/cart_screen.dart';
import 'package:hostel_essentials/screens/login_screen.dart';
import 'package:hostel_essentials/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences loginData;
    String email1='';
  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async{
    loginData=await SharedPreferences.getInstance();
    setState(() {
      email1=loginData.getString('email')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Essentric',
            style: kHeadingTextStyle,
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading:IconButton(
            onPressed: () async{
              loginData.setBool('login', true);
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.id);
            },
            icon: const Icon(Icons.logout,color: Colors.black,size: 27,),
          ),
          actions: [
            Badge(
              badgeColor: Colors.pink,
              position: BadgePosition.topEnd(top: -1,end: -0.5),
              badgeContent: Consumer<CartProvider>(
                builder: (context,value,child){
                  return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white),);
                },),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
                icon: const Icon(Icons.shopping_cart_outlined,color: Colors.black,size: 27,),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.03,
            )
          ],

        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              Text("Welcome $email1"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Items(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
