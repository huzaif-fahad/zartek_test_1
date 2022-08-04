// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:zartek_test/app_views/user_home_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen(
      {super.key,
      required this.addItemtoCartName,
      required this.addItemtoCartPrice,
      required this.addItemtoCartCalories,
      required this.total_items});
  List addItemtoCartName = [];
  List<int> addItemtoCartPrice = [];
  List addItemtoCartCalories = [];
  var total_items = 0;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  getDishNum() {
    Set dishnum;
    dishnum = widget.addItemtoCartName.toSet();
    return dishnum.length;
  }

  getTotalPrice() {
    int sum = 0;
    for (var i = 0; i < widget.addItemtoCartPrice.length; i++) {
      var ele = widget.addItemtoCartPrice[i];
      sum = sum + ele;
    }
    return sum;
  }

  SnackBar snackBar = const SnackBar(
    content: Text('Order Succesfully placed'),
  );
  sendCartCount() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "  Order Summary",
            style: TextStyle(color: Colors.grey),
          ),
          elevation: 0.5,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              )),
        ),
        body: CartScreenBody());
  }

  CartScreenBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${getDishNum()}  Dishes"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${widget.addItemtoCartName.length}  Items")
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: widget.total_items,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.addItemtoCartName[index],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                          "${widget.addItemtoCartPrice[index]}" " INR")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text("${widget.addItemtoCartPrice[index]}" " INR"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(widget.addItemtoCartCalories[index] +
                                      " Calories"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "${getTotalPrice()}  INR",
                            style: const TextStyle(fontSize: 17),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                placeOrder();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: Colors.green,
                  color: Colors.green,
                  elevation: 0,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  placeOrder() {
    widget.addItemtoCartName.clear();
    widget.addItemtoCartPrice.clear();
    widget.addItemtoCartCalories.clear();
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: ((context) => HomePage(Cartcounter: 0))));
    sendCartCount();
  }
}
