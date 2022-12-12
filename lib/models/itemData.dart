//Todo : create a static class and implement provider
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
final _firestore=FirebaseFirestore.instance;


class ItemData{
  static var product_list=[];

 static Future<bool> getData() async{
   bool state=false;

    await _firestore.collection("Items").get().then((event){
      product_list.clear();
      for ( var doc in event.docs){
        product_list.add(doc.data());
      }
      state=!state;

    });
    return state;
 }
}

