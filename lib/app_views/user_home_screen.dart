// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:zartek_test/app_models/dish_model.dart';

import 'package:zartek_test/app_services/remote_service.dart';

import 'package:zartek_test/app_views/checkout_screen.dart';
import 'package:zartek_test/app_views/side_navBar_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    addItemtoCartName.clear();
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addItemtoCartName.clear();
    addItemtoCartCalories.clear();
    addItemtoCartRupees.clear();
    _tabs.clear();
  }

  List<Dish>? dish;
  List<TableMenuList>? taml;
  List<CategoryDish>? catdish;
  List<Tab> _tabs = [];
  int counter = 0;
  List addItemtoCartName = [];
  List<int> addItemtoCartRupees = [];
  List addItemtoCartCalories = [];
  List<AddonCat> addOnCat = [];

  bool increment = false;

  checkifaddon(int taindex, cdishindex) {
    String? addonname = "Customizations Available";
    String noAddonNmae = '';
    bool addons = false;
    String addonCatItem;
    catdish = dish?.first.tableMenuList?[taindex].categoryDishes?.toList();
    addOnCat = catdish![cdishindex].addonCat!.toList();
    if (addOnCat.isNotEmpty) {
      addons = true;
      log("message");
    } else {
      addons = false;
    }
    if (addons) {
      return addonname;
    } else {
      return noAddonNmae;
    }
  }

  incrementCount(tindex, index) {
    increment = true;
    String count;
    String catdishitem;
    catdish = dish?.first.tableMenuList?[tindex].categoryDishes?.toList();
    catdishitem = catdish![index].dishName.toString();

    var map = {};

    addItemtoCartName.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    print(map[catdishitem]);
    if (map[catdishitem] != null) {
      count = map[catdishitem].toString();
    } else {
      count = '0';
    }
    return count;
  }

  DecrementCount(tindex, index) {
    increment = false;
    String count;
    String catdishitem;
    catdish = dish?.first.tableMenuList?[tindex].categoryDishes?.toList();
    catdishitem = catdish![index].dishName.toString();

    var map = {};

    addItemtoCartName.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] -= 1;
      }
    });
    print(map[catdishitem]);
    if (map[catdishitem] == null) {
      count = map[catdishitem].toString();
    } else {
      count = '0';
    }
    return count;
  }

  void toCart(int taindex, int cdishindex) {
    getCategorydishName(taindex, cdishindex);
    addItemtoCartName.add(getCategorydishName(taindex, cdishindex));
    addItemtoCartRupees.add(getCategorydishPrice(taindex, cdishindex));
    addItemtoCartCalories.add(getCategorydishCalories(taindex, cdishindex));
    setState(() {});
  }

  Future getData() async {
    dish = await RemoteService().getDish();
    taml = dish?.first.tableMenuList?.toList();
    getTabs();
    return taml;
  }

  getTabs() {
    List<Tab> Tablist = List.generate(
      taml!.length.toInt(),
      (index) => Tab(
        text: taml![index].menuCategory.toString(),
      ),
    );
    return Tablist;
  }

  getCategorydishName(int taindex, int cdishindex) {
    String catdishitem;

    catdish = dish?.first.tableMenuList?[taindex].categoryDishes?.toList();
    incrementCount(taindex, cdishindex);
    return catdishitem = catdish![cdishindex].dishName.toString();
  }

  getCategorydishPrice(int taindex, int cdishindex) {
    int dishPrice;

    catdish = dish?.first.tableMenuList?[taindex].categoryDishes?.toList();

    return dishPrice = catdish![cdishindex].dishPrice!.toInt();
  }

  getCategorydishCalories(int taindex, int cdishindex) {
    String dishCalories;
    catdish = dish?.first.tableMenuList?[taindex].categoryDishes?.toList();
    return dishCalories = catdish![cdishindex].dishCalories.toString();
  }

  getCategorydishDescription(int taindex, int cdishindex) {
    String dishDescription;

    return dishDescription = catdish![cdishindex].dishDescription.toString();
  }

  getCategorydishImages(int taindex, int cdishindex) {
    String dishImage;
    return dishImage = catdish![cdishindex].dishImage.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            log("has data");

            return HomePageBody();
          } else if (snapshot.hasError) {
            log("error");
          }

          return Container();
        },
        future: getData(),
      ),
    );
  }

  Widget HomePageBody() {
    _tabs = getTabs();
    var counter = 0;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.8,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SideNavBar()));
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => CartScreen(
                                addItemtoCartName: addItemtoCartName,
                                addItemtoCartPrice: addItemtoCartRupees,
                                addItemtoCartCalories: addItemtoCartCalories,
                                total_items: addItemtoCartName.length,
                              ))));
                    },
                    icon: const Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.grey,
                    )),
                Positioned(
                  right: 8,
                  top: 10,
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(addItemtoCartName.length.toString()),
                    ),
                  ),
                ),
              ],
            )
          ],
          bottom: TabBar(
              indicatorColor: Colors.purpleAccent,
              isScrollable: true,
              labelColor: Colors.black,
              tabs: _tabs),
        ),
        body: TabBarView(children: [
          HomepageBody(0),
          HomepageBody(1),
          HomepageBody(2),
          HomepageBody(3),
          HomepageBody(4),
          HomepageBody(5),
        ]),
      ),
    );
  }

  TextStyle headStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  Widget HomepageBody(int tindex) {
    return ListView.builder(
      itemCount: dish?.first.tableMenuList?[tindex].categoryDishes?.length,
      itemBuilder: (context, int index) {
        // return ListTile(
        //   title:
        // );
        checkifaddon(tindex, index);
        return Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getCategorydishName(tindex, index),
                  style: headStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("INR " + "${getCategorydishPrice(tindex, index)}"),
                    Text(getCategorydishCalories(tindex, index) + " Calories"),
                    Container(
                      height: 60,
                      child: CachedNetworkImage(
                          imageUrl: getCategorydishImages(tindex, index),
                          imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      // ignore: prefer_const_constructors
                                      colorFilter: ColorFilter.mode(
                                          Colors.red, BlendMode.colorBurn)),
                                ),
                              ),
                          placeholder: (context, url) =>
                              CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error)),
                    ),
                  ],
                ),
                Text(getCategorydishDescription(tindex, index)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50.0,
                  width: 150,
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    shadowColor: Colors.green,
                    color: Colors.green,
                    elevation: 0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                increment = false;
                                DecrementCount(tindex, index);
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            increment
                                ? incrementCount(tindex, index)
                                : DecrementCount(tindex, index),
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          IconButton(
                              onPressed: () {
                                toCart(tindex, index);
                                increment = true;
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  checkifaddon(tindex, index),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                )
              ],
            )),
          ),
        );
      },
    );
  }
}
