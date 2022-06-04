import 'dart:async';
import 'dart:convert';
import 'package:digitaez/Models/core/DishVoteModel.dart';
import 'package:digitaez/Models/service/DishService.dart';
import 'package:digitaez/Models/service/DishVoteService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/BottomNavBar.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Screens/DishScreen/AddDishSCreen/AddDish.dart';
import 'package:digitaez/Screens/DishScreen/Components/DishCardHorizontal.dart';
import 'package:digitaez/Screens/DishScreen/Components/DishCardVertical.dart';
import 'package:digitaez/Models/core/DishModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';

bool? voting;

class DishScreen extends StatefulWidget {
  const DishScreen({Key? key}) : super(key: key);

  @override
  _DishScreenState createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  PusherClient? pusher;
  int _AllIndex = 1;
  List<DishModel> _allItems = [];
  List<DishVoteModel> _allVotesItems = [];
  bool isloading1 = false;
  ScrollController _controller1 = ScrollController();
  Future<List<DishModel>>? _future1;
  Future<List<DishVoteModel>>? _future2;
  bool one1 = true;

  initState() {
    if (one1) {
      _future1 = getAll();
      _future2 = getVotes();

      one1 = false;
    }
    startTimer();
    _initPusher();
    super.initState();
    controllerListner1();
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

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();

// Disconnect from pusher service
    pusher!.disconnect();
  }

  Future<List<DishModel>> getAll() async {
    var payload = await DishService.getDish(_AllIndex);
    _allItems.addAll(payload);
    if (payload.length != 0) _AllIndex++;
    return _allItems;
  }

  Future<List<DishVoteModel>> getVotes() async {
    _allVotesItems = await DishVoteService.getVoteDish(1);
    return _allVotesItems;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Duration duration = Duration();

  void startTimer() {
    final timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    duration = Duration(
        seconds: (DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 17, 0, 0)
                .difference(DateTime.now()))
            .inSeconds);
  }

  void addTime() {
    final addSeconds = -1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds > 0) {
        duration = Duration(seconds: seconds);
        voting = true;
      } else {
        duration = Duration(seconds: 0);
        voting = false;
        _allVotesItems.clear();
      }
    });
  }

  Future<void> _initPusher() async {
    pusher =
        PusherClient('7508b0c26ee7ac35ad79', PusherOptions(cluster: 'ap2'));
    var _user = Provider.of<UserNotifier>(context, listen: false).getuser();
    //  var _user = Provider.of<UserNotifier>(context).getuser();
    print('channel:' + _user.officeId.toString());

    var channel = pusher!.subscribe(_user.officeId.toString());

    pusher!.onConnectionStateChange((state) {
      print(
          "previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });

    pusher!.onConnectionError((error) {
      print("error: ${error!.message}");
    });

    channel.bind('Vote', (event) {
      final parsed = json.decode(event!.data!);
      int index = _allVotesItems
          .indexWhere((element) => element.id == parsed['dishId']);
      if (index == -1) {
        _allVotesItems.add(new DishVoteModel(
            name: parsed['dishName'],
            id: parsed['dishId'],
            vote: 1,
            image: parsed['image']));
      } else {
        _allVotesItems[index].vote++;
      }
      _allVotesItems.sort((a, b) => b.vote.compareTo(a.vote));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(
        context,
        "Food For Lunch",
        () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomNavBar(navPos: 0)));
        },
      ),
      body: Padding(
        padding: new EdgeInsets.symmetric(horizontal: height * 0.01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Most Voted Dish",
                  style: TextStyle(
                      fontSize: height * 0.024, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: new EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.016)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            spreadRadius: 2,
                            offset: Offset(1, 2),
                            blurRadius: 2,
                          ),
                        ]),
                    child: Padding(
                      padding: new EdgeInsets.symmetric(
                          vertical: height * 0.005, horizontal: width * 0.02),
                      child: Row(
                        children: [
                          Padding(
                            padding: new EdgeInsets.only(right: width * 0.01),
                            child: Icon(
                              Icons.timer,
                              size: height * 0.022,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.015,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              // width: width,

              height: height * 0.115,
              child: FutureBuilder(
                  future: _future2,
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<DishVoteModel>> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container(
                        height: height * 0.2,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasData && _allVotesItems.length != 0) {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _allVotesItems.length,
                          itemBuilder: (BuildContext context, int index) =>
                              DishCardHorizontal(
                                  dish: _allVotesItems[index], index: index));
                    } else {
                      return Container(
                        height: height * 0.03,
                        child: Center(
                          child: Text("No Vote to show"),
                        ),
                      );
                    }
                  }),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Dish List",
                  style: TextStyle(
                      fontSize: height * 0.024, fontWeight: FontWeight.w600),
                ),
                InkWell(
                    child: Padding(
                      padding: new EdgeInsets.only(
                          right: width * 0.02, top: height * 0.011),
                      child: Text(
                        "+ Add Dish",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3897b6)),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddDish()));
                    }),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
                child: FutureBuilder(
                    future: _future1,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<List<DishModel>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData && _allItems.length != 0) {
                        return ListView.builder(
                            controller: _controller1,
                            itemCount: _allItems.length,
                            itemBuilder: (BuildContext context, int index) =>
                                DishCardVertical(
                                  dish: _allItems[index],
                                  index: index,
                                  length: _allItems.length,
                                  isloading: isloading1,
                                ));
                      } else
                        return Container(
                          height: height * 0.6,
                          child: Center(child: Text("No Dish to show")),
                        );
                    })

                // Container(
                //     //  height: height * 0.6,
                //     child: dish.length == 0
                //         ? Center(child: Text('No Dish to view'))
                //         : ListView.builder(
                //             shrinkWrap: true,
                //             // scrollDirection: Axis.horizontal,
                //             itemCount: dish.length,
                //             itemBuilder: (BuildContext context, int index) =>
                //                 DishCardVertical(
                //                     dish: dish[index], index: index)))

                ),
          ],
        ),
      ),
    );
  }
}
