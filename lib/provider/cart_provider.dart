import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/dbHelper.dart';
import '../models/Cart_model.dart';
class CartProvider with ChangeNotifier{
  int _counter=0;
 // int get counter=>_counter;
  DBHelper db=DBHelper();
  double _totalPrice=0.0;
  double get totalPrice=>_totalPrice;
  late Future<List<Cart>> _cart;

  Future<List<Cart>> get cart=>_cart;

  Future<List<Cart>> getData() async{
    _cart=db.getCartList();
    return _cart;
  }
  void _setPreference() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPreference() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    _counter=prefs.getInt('cart_item')??0;
    _totalPrice=prefs.getDouble('total_price')??0.0;
    notifyListeners();
  }

  void addTotalPrice(double price){
    _totalPrice=_totalPrice+price;
    _setPreference();
    notifyListeners();
  }

  void removeTotalPrice(double price){
    _totalPrice=_totalPrice-price;
    _setPreference();
    notifyListeners();
  }

  double getTotalPrice(){
    _getPreference();
    return _totalPrice;
  }

  void addCounter(){
    _counter++;
    _setPreference();
    notifyListeners();
  }

  void removeCounter(){
    _counter--;
    _setPreference();
    notifyListeners();
  }

  int getCounter(){
    _getPreference();
    return _counter;
  }
}