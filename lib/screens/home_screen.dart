import 'package:flutter/material.dart';
import 'package:hostel_essentials/constants.dart';
import 'package:hostel_essentials/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences loginData;
   late String email1;
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
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      loginData.setBool('login', true);
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    icon: Icon(Icons.logout),
                  ),
                  Text(
                    'Essentric',
                    style: kHeadingTextStyle,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.04,
              ),
              Text("Welcome Back $email1"),
            ],
          ),
        ),
      ),
    );
  }
}
