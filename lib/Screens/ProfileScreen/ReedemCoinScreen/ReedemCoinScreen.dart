import 'package:digitaez/Models/service/ProductService.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Models/core/ProductModel.dart';
import 'package:digitaez/Screens/ProfileScreen/ReedemCoinScreen/ProductCard.dart';
import 'package:digitaez/Screens/ProfileScreen/Components/ScrollableButtons.dart';
import 'package:flutter/material.dart';

List<String> options = ["All", "Food Items", "Tech Items"];

class RedeemCoinScreen extends StatefulWidget {
  const RedeemCoinScreen({Key? key}) : super(key: key);

  @override
  _RedeemCoinScreenState createState() => _RedeemCoinScreenState();
}

class _RedeemCoinScreenState extends State<RedeemCoinScreen> {
  int _selectedIndex = 0;
  int _AllIndex = 1;
  int _FoodIndex = 1;
  int _TechIndex = 1;
  List<ProductModel> _allItems = [];
  List<ProductModel> _foodItems = [];
  List<ProductModel> _techItems = [];
  bool isloading1 = false;
  bool isloading2 = false;
  bool isloading3 = false;
  ScrollController _controller1 = ScrollController();
  ScrollController _controller2 = ScrollController();
  ScrollController _controller3 = ScrollController();
  Future<List<ProductModel>>? _future1;
  Future<List<ProductModel>>? _future2;
  Future<List<ProductModel>>? _future3;
  bool one1 = true;
  bool one2 = true;
  bool one3 = true;

  initState() {
    if (one1) {
      _future1 = getAll();
      one1 = false;
    }
    if (one2) {
      _future2 = getFood();
      one2 = false;
    }
    if (one3) {
      _future3 = getTech();
      one3 = false;
    }

    super.initState();
    controllerListner1();
    controllerListner2();
    controllerListner3();
  }

  void controllerListner1() {
    _controller1.addListener(() async {
      if (_controller1.position.pixels ==
          _controller1.position.maxScrollExtent) {
        setState(() {
          isloading1 = true;
        });
        await getAll();
        setState(() {
          isloading1 = false;
        });
      }
    });
  }

  void controllerListner2() {
    _controller2.addListener(() async {
      if (_controller2.position.pixels ==
          _controller2.position.maxScrollExtent) {
        setState(() {
          isloading2 = true;
        });
        await getFood();
        setState(() {
          isloading2 = false;
        });
      }
    });
  }

  void controllerListner3() {
    _controller3.addListener(() async {
      if (_controller3.position.pixels ==
          _controller3.position.maxScrollExtent) {
        setState(() {
          isloading3 = true;
        });
        await getTech();
        setState(() {
          isloading3 = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Future<List<ProductModel>> getAll() async {
    var payload = await ProductService.getProduct("All", _AllIndex);
    _allItems.addAll(payload);
    if (payload.length != 0) _AllIndex++;
    return _allItems;
  }

  Future<List<ProductModel>> getFood() async {
    var payload = await ProductService.getProduct("Food", _FoodIndex);
    _foodItems.addAll(payload);
    if (payload.length != 0) _FoodIndex++;
    return _foodItems;
  }

  Future<List<ProductModel>> getTech() async {
    var payload = await ProductService.getProduct("Tech", _TechIndex);
    _techItems.addAll(payload);
    if (payload.length != 0) _TechIndex++;
    return _techItems;
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: appBar(
        context,
        "Redeem Coins",
        () {
          Navigator.pop(context);
        },
      ),

      body: Column(
        children: [
          Container(
            height: height * 0.09,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) =>
                    ScrollableButton(
                        index: index,
                        selectedIndex: _selectedIndex,
                        option: options[index],
                        function: _onSelected)),
          ),
          Expanded(
            child: _selectedIndex == 0
                ? FutureBuilder(
                    future: _future1,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<List<ProductModel>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Color(0xFF7CC050),
                        ));
                      }
                      if (snapshot.hasData && _allItems.length != 0) {
                        return GridView.builder(
                            controller: _controller1,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: width / (height / 1.65),
                            ),
                            itemCount: _allItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard(
                                product: _allItems[index],
                                isloading: isloading1,
                                index: index,
                                last: _allItems.length,
                              );
                            });
                      }
                      return Center(child: Text("No product to show"));
                    })
                : _selectedIndex == 1
                    ? FutureBuilder(
                        future: _future2,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<List<ProductModel>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Color(0xFF7CC050),
                            ));
                          }
                          if (snapshot.hasData && _foodItems.length != 0) {
                            return GridView.builder(
                                controller: _controller2,
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: width / (height / 1.65),
                                ),
                                itemCount: _foodItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductCard(
                                      product: _foodItems[index],
                                      isloading: isloading2,
                                      index: index,
                                      last: _foodItems.length);
                                });
                          }
                          return Center(child: Text("No product to show"));
                        })
                    : FutureBuilder(
                        future: _future3,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<List<ProductModel>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Color(0xFF7CC050),
                            ));
                          }
                          if (snapshot.hasData && _techItems.length != 0) {
                            return GridView.builder(
                                controller: _controller3,
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: width / (height / 1.65),
                                ),
                                itemCount: _techItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductCard(
                                    product: _techItems[index],
                                    isloading: isloading3,
                                    index: index,
                                    last: _techItems.length,
                                  );
                                });
                          }
                          return Center(child: Text("No product to show"));
                        },
                      ),
          )
        ],
      ),
    );
  }
}
