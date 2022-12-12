class Cart
{
  int? id;
  String? ItemId;
  String? name;
  String? initialPrice;
  int? price;
  String? quantity;
  String? image;

  Cart({this.id, this.ItemId, this.name, this.initialPrice, this.price,
    this.quantity, this.image});
//to fetch data from the server
  Cart.fromMap(Map<dynamic,dynamic> res):
      id= res['id'],
      image= res['image'],
      price=res['price'],
      name=res['name'];




  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'image':image,
      'name':name,
      'price':price,
    };
  }

}