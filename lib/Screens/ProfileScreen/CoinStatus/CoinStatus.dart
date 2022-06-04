import 'package:digitaez/Models/core/EarnedCoins.dart';
import 'package:digitaez/Models/core/RedeemCoin.dart';
import 'package:digitaez/Models/service/EarnCoinServive.dart';
import 'package:digitaez/Models/service/RedeemCoinService.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Screens/NotificationScreen/Components/NotificationVertical.dart';
import 'package:digitaez/Screens/ProfileScreen/CoinStatus/Component/RedeemCoinCard.dart';
import 'package:digitaez/Screens/ProfileScreen/Components/ScrollableButtons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> options = ["Earned", "Redeemed"];

class CoinStatustScreen extends StatefulWidget {
  const CoinStatustScreen({Key? key}) : super(key: key);

  @override
  _CoinStatustScreenState createState() => _CoinStatustScreenState();
}

class _CoinStatustScreenState extends State<CoinStatustScreen> {
  int _selectedIndex = 0;
  int _earncoinIndex = 1;
  int _redeemcoinIndex = 1;
  bool isloading1 = false;
  bool isloading2 = false;
  List<EarnedCoinsModel> _EarnList = [];
  List<RedeemCoinModel> _RedeemList = [];
  ScrollController _controller1 = ScrollController();
  ScrollController _controller2 = ScrollController();
  Future<List<EarnedCoinsModel>>? _future1;
  Future<List<RedeemCoinModel>>? _future2;
  bool one1 = true;
  bool one2 = true;

  initState() {
    if (one1) {
      _future1 = getRewards();
      one1 = false;
    }
    if (one2) {
      _future2 = getRedeems();
      one2 = false;
    }

    super.initState();
    controllerListner1();
    controllerListner2();
  }

  void controllerListner1() {
    _controller1.addListener(() async {
      if (_controller1.position.pixels ==
          _controller1.position.maxScrollExtent) {
        setState(() {
          isloading1 = true;
        });
        await getRewards();
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
        await getRedeems();
        setState(() {
          isloading2 = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Future<List<EarnedCoinsModel>> getRewards() async {
    var payload = await EarnedCoinService.getEarnedCoin(_earncoinIndex);
    _EarnList.addAll(payload);
    if (payload.length != 0) _earncoinIndex++;
    return _EarnList;
  }

  Future<List<RedeemCoinModel>> getRedeems() async {
    var payload = await RedeemCoinService.getRedeemCoin(_redeemcoinIndex);
    _RedeemList.addAll(payload);
    if (payload.length != 0) _redeemcoinIndex++;
    return _RedeemList;
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: appBar(context, "SiniCoins", () {
        Navigator.pop(context);
      }),
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
                          AsyncSnapshot<List<EarnedCoinsModel>> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Color(0xFF7CC050),
                          ));
                        }

                        if (snapshot.hasData && _EarnList.length != 0) {
                          return ListView.builder(
                            controller: _controller1,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025),
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    warningBar1(context, "Coin", index + 1),
                                    announcementBar1(
                                        context,
                                        _EarnList[index].description,
                                        DateFormat('dd MMMM yyyy')
                                            .format(_EarnList[index].createAt),
                                        index + 1,
                                        true,
                                        time: DateFormat('hh:mm aa')
                                            .format(_EarnList[index].createAt))
                                  ],
                                ),
                                index == _EarnList.length - 1
                                    ? Container(
                                        height: isloading1 ? 50.0 : 0,
                                        color: Colors.transparent,
                                        child: Center(
                                          child:
                                              new CircularProgressIndicator( color: Color(0xFF7CC050),),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0,
                                      ),
                                SizedBox(
                                    height:
                                        index == _EarnList.length - 1 ? 70 : 0),
                              ],
                            ),
                          );
                        }
                        return Center(child: Text("No rewards to show"));
                      })
                  : FutureBuilder(
                      future: _future2,
                      builder: (BuildContext ctx,
                          AsyncSnapshot<List<RedeemCoinModel>> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Center(child: CircularProgressIndicator( color: Color(0xFF7CC050),));
                        }

                        if (snapshot.hasData && _EarnList.length != 0) {
                          return ListView.builder(
                            controller: _controller2,
                            itemCount: _RedeemList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RedeemProductCard(
                                  wallet: _RedeemList[index],
                                  index: index,
                                  last: _RedeemList.length,
                                  isloading: isloading2,
                                ),
                              ],
                            ),
                          );
                        }
                        return Center(child: Text("No redeem to show"));
                      })),
        ],
      ),
    );
  }
}
