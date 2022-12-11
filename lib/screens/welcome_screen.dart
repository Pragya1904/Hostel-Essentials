import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/screens/login_screen.dart';
import 'package:hostel_essentials/screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
    controller.forward();
    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                     Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height*0.4,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                     DefaultTextStyle(
                       style: TextStyle(
                           color: Colors.grey[500],
                           fontSize: 45,
                           fontWeight: FontWeight.w900),
                       child: AnimatedTextKit(animatedTexts: [
                         RotateAnimatedText(
                           'ESSENTRIC',
                         ),
                         RotateAnimatedText('Hostel Essentials',textStyle: TextStyle(fontSize: 30) ),
                       ],
                         repeatForever: true,
                       ),
                     ),
                  // AnimatedTextKit(animatedTexts:[RotateAnimatedText('Essentric'),RotateAnimatedText('Hostel Essentials')],
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text('Continue'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text("You are not a member?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text("Sign-Up"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
