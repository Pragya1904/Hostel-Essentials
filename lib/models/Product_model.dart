class Product
{
   String? id;
   String? ItemId;
   String? name;
   String? initialPrice;
   String? price;
   String? quantity;
   String? image;

  Product({this.id, this.ItemId, this.name, this.initialPrice, this.price,
      this.quantity, this.image});
//to fetch data from the server
  factory Product.fromMap(map){
    return Product(
      id: map['id'],
      image: map['image'],
      price: map['price'],
      name: map['name'],
    );
  }


  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'image':image,
      'name':name,
      'price':price,
    };
  }

}