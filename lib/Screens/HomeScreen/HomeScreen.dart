import 'package:auto_size_text/auto_size_text.dart';
import 'package:digitaez/Models/service/OfficeTiming.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/HomeScreen/Components/AttendanceBar.dart';
import 'package:digitaez/Screens/HomeScreen/Components/ClippingClass.dart';
import 'package:digitaez/Screens/HomeScreen/Components/EmployeeBar.dart';
import 'package:digitaez/Screens/HomeScreen/Components/RedeemBar.dart';
import 'package:digitaez/Screens/HomeScreen/Components/ScrollableEmployees.dart';
import 'package:digitaez/Screens/HomeScreen/Components/cards.dart';
import 'package:digitaez/Screens/HomeScreen/Components/leaveBar.dart';
import 'package:digitaez/Screens/ProfileScreen/CoinStatus/CoinStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/help_Bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _mycontroller1 =
      new ScrollController(); // make seperate controllers
  ScrollController _mycontroller2 =
      new ScrollController(); // for each scrollables

  String timming = "--";
  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    var response = await OfficeTimng.getOfficeTiming();

    setState(() {
      timming = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var model = Provider.of<UserNotifier>(context);
    final _user = Provider.of<UserNotifier>(context).getuser();
    return Scaffold(
      appBar: null,
      body: Container(
        // color: Colors.amber,
        height: height,
        width: width,
        child: NotificationListener<ScrollNotification>(
            child: Stack(children: [
              SingleChildScrollView(
                controller: _mycontroller1,
                child: Column(
                  children: [
                    ClipPath(
                      clipper: ClippingClass(),
                      child: Container(
                          height: height * 0.35,
                          width: width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xFF72BAA8), Color(0xFF7CC055)]),
                          )),
                    ),
                    Container(
                        height: height * 2,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Positioned(
                  top: height * 0.03,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: height,
                    width: width,
                    child: SingleChildScrollView(
                        controller: _mycontroller2,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.36,
                                        child: Card(
                                          elevation: 3,
                                          color: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Welcome Back",
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.016,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              AutoSizeText(
                                                _user.username.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child: Card(
                                              elevation: 3,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0,
                                                    bottom: 4,
                                                    right: 10,
                                                    left: 4),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/sinicoins.png',
                                                      // fit: BoxFit.contain,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.03,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Text(
                                                          _user.coins
                                                                  .toString()
                                                                  .toString() +
                                                              ' SNC',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.015)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CoinStatustScreen()),
                                              );
                                            },
                                          ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     // Navigator.push(
                                          //     //     context,
                                          //     //     MaterialPageRoute(
                                          //     //         builder: (context) =>
                                          //     //             NotificationScreen()));
                                          //   },
                                          //   child: Card(
                                          //     elevation: 3,
                                          //     //shadowColor: Colors.transparent,
                                          //     color: Colors.white,
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(30),
                                          //     ),
                                          //     child: Stack(
                                          //         alignment:
                                          //             Alignment.bottomRight,
                                          //         children: [
                                          //           Padding(
                                          //             padding: new EdgeInsets
                                          //                     .all(
                                          //                 MediaQuery.of(context)
                                          //                         .size
                                          //                         .height *
                                          //                     0.008),
                                          //             child: SvgPicture.asset(
                                          //               'assets/images/notification.svg',
                                          //               fit: BoxFit.fitHeight,
                                          //               height: MediaQuery.of(
                                          //                           context)
                                          //                       .size
                                          //                       .height *
                                          //                   0.022,
                                          //               // scale: 0.8,
                                          //             ),
                                          //           ),
                                          //           SizedBox(
                                          //             child: CircleAvatar(
                                          //               radius: MediaQuery.of(
                                          //                           context)
                                          //                       .size
                                          //                       .height *
                                          //                   0.008,
                                          //               backgroundColor:
                                          //                   Color(0xFF5cc5c1),
                                          //               child: Text(
                                          //                 "4",
                                          //                 style: TextStyle(
                                          //                     fontSize: MediaQuery.of(
                                          //                                 context)
                                          //                             .size
                                          //                             .height *
                                          //                         0.013,
                                          //                     color:
                                          //                         Colors.white),
                                          //               ),
                                          //             ),
                                          //           )
                                          //         ]),
                                          //   ),
                                          // )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                  // InkWell(
                                  //   child: Stack(
                                  //     alignment: Alignment.centerRight,
                                  //     children: [
                                  //       warningBar(
                                  //           context, Notifications[0].type),
                                  //       announcementBar(
                                  //           context,
                                  //           Notifications[0].title,
                                  //           Notifications[0].description)
                                  //     ],
                                  //   ),
                                  //   onTap: () {
                                  //     // Navigator.push(
                                  //     //     context,
                                  //     //     MaterialPageRoute(
                                  //     //         builder: (context) =>
                                  //     //             NotificationScreen()));
                                  //   },
                                  // ),
                                  //SizedBox(height: height * 0.03),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          cardImageBar(context,
                                              "assets/images/clock.svg"),
                                          cardBar(context, "Office Timings",
                                              timming)
                                        ],
                                      ),
                                      // Stack(
                                      //   alignment: Alignment.centerRight,
                                      //   children: [
                                      //     cardImageBar(context,
                                      //         "assets/images/dish.svg"),
                                      //     cardBar(context, "Food for Lunch",
                                      //         "Voting is Continue")
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.03),
                                  attendanceBar(context,
                                      model.getuser().attendanceMark ?? ""),
                                  SizedBox(height: height * 0.03),
                                  leaveBar(context),
                                  SizedBox(height: height * 0.03),
                                  RedeemBarSt(),
                                  SizedBox(height: height * 0.03),
                                  ScrollableEmployees("Employee of the Day"),
                                  SizedBox(height: height * 0.03),
                                  EmployeeBar("Employee of the Month"),
                                  // SizedBox(height: height * 0.03),
                                  // NeedHelp(),
                                  SizedBox(height: height * 0.15),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                          ],
                        )),
                  )),
            ]),
            onNotification: (ScrollNotification scrollInfo) {
              // HEY!! LISTEN!!
              // this will set controller1's offset the same as controller2's
              _mycontroller1.jumpTo(_mycontroller2.offset);
              return true;
            }),
      ),
    );
  }
}
