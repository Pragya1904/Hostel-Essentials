//Todo : create a static class and implement provider
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hostel_essentials/models/Product_model.dart';
final _firestore=FirebaseFirestore.instance;


class ItemData{
  static List<Product> itemData=[];
  static var product_list=[];

 static Future<bool> getData() async{
   bool state=false;

    await _firestore.collection("Items").get().then((event){
      product_list.clear();
      for ( var doc in event.docs){
        product_list.add(doc.data());
        //print("${doc.id}=>${doc.data()}");
      }
      // if (kDebugMode) {
      //   print(product_list[0]['price']);
      // }
      state=!state;

      //event.docs.map((e) => ItemData.itemData.add(Product.fromMap(e.data())));
    });
    return state;
 }
}

