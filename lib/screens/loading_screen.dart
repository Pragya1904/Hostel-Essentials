import 'package:flutter/material.dart';
import 'package:hostel_essentials/screens/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/itemData.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
static String id='loading_screen';
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
        builder:(context,AsyncSnapshot<bool?> snapshot){
          if(snapshot.data==true)
            {
              return HomeScreen();
            }
          else
            {
              return
                Scaffold(
                  body: SpinKitRipple(
                    color:Colors.pink,
                    size: 200,
                  ),
                );
            }
        },
      future: ItemData.getData(),
    );
  }
}
