import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hostel_essentials/models/Cart_model.dart';
import 'package:path/path.dart';
class DBHelper{
  static Database? _db;

  Future<Database?> get db async {
    await deleteDatabase();
      if(_db!=null)
        {
          return _db!;
        }
      _db=await initDatabase();
    }
    Future<void> deleteDatabase() async {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'cart.db');
      databaseFactory.deleteDatabase(path);
    }

    //creates a path to setup local database in mobile systems
    initDatabase() async{
      io.Directory documentDirectory=await getApplicationDocumentsDirectory();
      String path=join(documentDirectory.path,'cart.db');
      var db=await openDatabase(path,version: 1,onCreate: _onCreate);
      return db;
    }

    _onCreate(Database db, int version) async {
      await db
          .execute(
          "CREATE TABLE cart (id NUMBER PRIMARY KEY,name VARCHAR,price NUMBER,image VARCHAR,quantity NUMBER,ProductPrice NUMBER)"
      );
    }
    Future<Cart> insert(Cart cart) async {
      var dbClient = await db;
      await dbClient!.insert('cart', cart.toMap());
      return cart;
    }

    Future<List<Cart>> getCartList() async {
      var dbClient = await db;
      final List<Map<String, Object?>> queryResult = await dbClient!.query(
          'cart');
      return queryResult.map((e) => Cart.fromMap(e)).toList();
    }

    Future<int> delete(int id) async {
      var dbClient = await db;
      return await dbClient!.delete('cart', where: 'id=?', whereArgs: [id]);
    }
  }