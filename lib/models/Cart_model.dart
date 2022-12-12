class Cart
{
  int? id;
  String? ItemId;
  String? name;
  int? ProductPrice;
  int? price;
  int? quantity;
  String? image;

  Cart({this.id, this.ItemId, this.name, this.ProductPrice, this.price,
    this.quantity, this.image});
//to fetch data from the server
  Cart.fromMap(Map<dynamic,dynamic> res):
      id= res['id'],
      image= res['image'],
      price=res['price'],
      quantity=res['quantity'],
      ProductPrice=res['ProductPrice'],
      name=res['name'];




  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'quantity':quantity,
      'image':image,
      'name':name,
      'ProductPrice':ProductPrice,
      'price':price,
    };
  }

}