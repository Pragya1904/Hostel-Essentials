import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hostel_essentials/database/dbHelper.dart';
import 'package:hostel_essentials/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cart_provider.dart';
import '../constants.dart';
import '../models/Cart_model.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
static const String id='cart_screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late SharedPreferences loginData;
  DBHelper dbHelper=DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: kHeadingTextStyle,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading:IconButton(
          onPressed: () {
            loginData.setBool('login', true);
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
      body: Column(
        children: [
          FutureBuilder(future: cart.getData(),
              builder: (context,AsyncSnapshot<List<Cart>> snapshot){
                if(snapshot.hasData)
                  {
                    return Expanded(child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: snapshot.data![index].image.toString(),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.image),
                                          height: MediaQuery.of(context).size.height * 0.13,
                                          width: MediaQuery.of(context).size.width * 0.2,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.04,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data![index].name.toString(),
                                                    style: kItemTextStyle,
                                                  ),
                                                  IconButton(onPressed: (){
                                                    dbHelper!.delete(snapshot.data![index].id!);
                                                    cart.removeCounter();
                                                    cart.removeTotalPrice(double.parse(snapshot.data![index].price.toString()));
                                                  }, icon:const Icon(Icons.delete)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height *
                                                    0.01,
                                              ),
                                              Text(
                                                "₹${snapshot.data![index].price}",
                                                style: kItemTextStyle,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height *
                                                    0.01,
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child:Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.pink,
                                                    borderRadius: BorderRadius.circular(7)
                                                  ),
                                                  height: MediaQuery.of(context).size.height*0.045,
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      IconButton(onPressed: (){}, icon: Icon(Icons.remove,color: Colors.white,)),
                                                      Text("!",style: TextStyle(color: Colors.white,fontSize: 20)),
                                                      IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.white,)),

                                                    ],
                                                  ),
                                                )
                                              ),

                                            ],
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              ));
                        }));
                  }
                else
                  {
                      return Text("Your Cart is so Light...Add some Products");
                      //todo: add empty cart image and redirect the users to homescreen
                  }
              }
          ),
          Consumer<CartProvider>(builder: (context,value,child){
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2)=='0.00'?false:true ,
              child: Column(
                children: [
                  ReusableCard(title: "SubTotal", value: "${value.getTotalPrice().toStringAsFixed(2)}"),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String title,value;

  const ReusableCard({ required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: kItemTextStyle,),
            Text("₹$value",style: kItemTextStyle,),
        ],
      ),
    );
  }
}
