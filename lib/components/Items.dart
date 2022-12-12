import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hostel_essentials/provider/cart_provider.dart';
import 'package:hostel_essentials/database/dbHelper.dart';
import 'package:hostel_essentials/models/Cart_model.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:hostel_essentials/models/itemData.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  DBHelper? dbHelper = DBHelper();
  @override
  void initState() {
    ItemData.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: ItemData.product_list.length,
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
                              imageUrl: ItemData.product_list[index]['image'],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image),
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
                                  Text(
                                    ItemData.product_list[index]['name'],
                                    style: kItemTextStyle,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    "₹${ItemData.product_list[index]['price']}",
                                    style: kItemTextStyle,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                        onPressed: () {

                                          dbHelper!
                                              .insert(Cart(
                                                  id: index,
                                                  price: ItemData
                                                          .product_list[index]
                                                      ['price'],
                                                  image: ItemData
                                                          .product_list[index]
                                                      ['image'],
                                                  ProductPrice:ItemData.product_list[index]['price'],
                                                  quantity: 1,
                                                  name: ItemData
                                                          .product_list[index]
                                                      ['name']))
                                              .then((value) {
                                            if (kDebugMode) {
                                              print("Product added to cart");
                                            }
                                            cart.addTotalPrice(double.parse(
                                                ItemData.product_list[index]
                                                        ['price']
                                                    .toString()));
                                            cart.addCounter();
                                          }).onError((error, stackTrace) {
                                            if (kDebugMode) {
                                              print(error);
                                            }
                                          });
                                          //  print(Cart);
                                        },
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                  ));
                }))
      ],
    );
  }
}
