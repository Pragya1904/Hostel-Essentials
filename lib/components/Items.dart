import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_essentials/models/Product_model.dart';
import '../constants.dart';
import 'package:hostel_essentials/models/itemData.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}


class _ItemsState extends State<Items> {

  @override
  void initState() {
     ItemData.getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(ItemData.product_list.length);
    return Column(
      children: [
        Expanded(
          flex: 1,
            child: ListView.builder(
          itemCount:ItemData.product_list.length,
            itemBuilder: (context,index){
          return Card(
            child:Padding(
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
                      Image(image:NetworkImage(ItemData.product_list[index]['image']),height: MediaQuery.of(context).size.height*0.13,width: MediaQuery.of(context).size.width*0.2,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.04,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ItemData.product_list[index]['name'],style: kItemTextStyle,),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.01,
                            ),
                            Text("₹${ItemData.product_list[index]['price']}",style: kItemTextStyle,),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.01,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(onPressed: (){},style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ))),
                                  child: const Text("Add To Cart")),
                            ),
                          ],
                        ),
                      ),


                    ],
                  )
                ],
              ),
            )
          );
        }))
      ],
    );
  }
}


