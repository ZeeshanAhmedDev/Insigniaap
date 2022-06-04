import 'package:digitaez/Models/service/AttendanceService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/BottomNavBar.dart';
import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Models/core/AttendanceModel.dart';
import 'package:digitaez/Screens/LoginScreen/SignInScreen.dart';
import 'package:digitaez/Screens/ProfileScreen/AttendanceScreen/AttendanceScreen.dart';
import 'package:digitaez/Screens/ProfileScreen/CoinStatus/CoinStatus.dart';
import 'package:digitaez/Screens/ProfileScreen/Components/Siginoutpopup.dart';
import 'package:digitaez/Screens/ProfileScreen/Components/attendanceListView.dart';
import 'package:digitaez/Screens/ProfileScreen/PendingRequestScreen/PendingRequest.dart';
import 'package:digitaez/Screens/ProfileScreen/ReedemCoinScreen/ReedemCoinScreen.dart';
import 'package:digitaez/Screens/ProfileScreen/LeaveScreen/RequestLeave.dart';
import 'package:digitaez/Screens/ProfileScreen/EditProfile/EditProfile.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController _mycontroller1 =
      new ScrollController(); // make seperate controllers
  ScrollController _mycontroller2 =
      new ScrollController(); // for each scrollables
  int _imageVersion = 1;

  Future<void> _refreshImage() async {
    //call API & update the image
    _imageVersion++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print("state");
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final _user = Provider.of<UserNotifier>(context).getuser();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: height,
          width: width,
          child: NotificationListener<ScrollNotification>(
              child: Stack(children: [
                SingleChildScrollView(
                  controller: _mycontroller1,
                  child: Column(
                    children: [
                      // SvgPicture.asset(
                      //   'assets/images/background2.svg',
                      //   fit: BoxFit.cover,
                      //   width: width,
                      //   // height: height * 0.24,
                      // ),
                      // ClipPath(
                      //   clipper: ClippingClass(),
                      //   child: Container(
                      //       height: 200,r
                      //       width: width,
                      //       decoration: BoxDecoration(
                      //         gradient: LinearGradient(
                      //             begin: Alignment.centerLeft,
                      //             end: Alignment.centerRight,
                      //             colors: [
                      //               Color(0xFF5cc5c1),
                      //               Color(0xFF268db8)
                      //             ]),
                      //       )),
                      // ),
                      Container(
                        height: height * 4,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: height,
                      width: width,
                      child: SingleChildScrollView(
                          controller: _mycontroller2,
                          child: Row(
                            children: [
                              SizedBox(width: width * 0.02),
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: width * 0.01,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: (() {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBar(navPos: 0),
                                              ),
                                            );
                                          }),
                                          icon: Icon(Icons.arrow_back),
                                          iconSize: height * 0.03,
                                          color: Colors.white,
                                        ),
                                        PopupMenubutton<String>(
                                          offset: Offset(0, height * 0.04),
                                          icon: Icon(
                                            Icons.more_horiz,
                                            size: height * 0.03,
                                            color: Colors.black,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(height * 0.015),
                                            ),
                                          ),
                                          onSelected: (item) async {
                                            Navigator.pop(context);
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.clear();

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Signin()));
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return {'Sign Out'}
                                                .map((String choice) {
                                              return PopupMenuitem<String>(
                                                height: height * 0.06,
                                                value: choice,
                                                child: Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Transform.rotate(
                                                          angle:
                                                              180 * 3.142 / 180,
                                                          child: Icon(
                                                            Icons
                                                                .logout_outlined,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.025,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              new EdgeInsets
                                                                      .only(
                                                                  left: width *
                                                                      0.007),
                                                          child: Text(
                                                            choice,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.016),
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                              );
                                            }).toList();
                                          },
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: width > 450
                                              ? width * 0.1
                                              : height * 0.02),
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              height * 0.1),
                                        ),
                                        child: Padding(
                                          padding: new EdgeInsets.all(
                                              height * 0.006),
                                          child: Card(
                                              elevation: 5,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: height * 0.063,
                                                child: _user.photo ==
                                                        "no-photo.jpg"
                                                    ? SvgPicture.asset(
                                                        'assets/images/profile-circle.svg')
                                                    : null,
                                                backgroundImage: _user.photo ==
                                                        "no-photo.jpg"
                                                    ? null
                                                    : NetworkImage(
                                                        Constants
                                                                .profileUploads +
                                                            _user.photo! +
                                                            '#v=$_imageVersion',
                                                      ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        height * 0.07),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: new EdgeInsets.only(
                                          top: height * 0.008,
                                          bottom: height * 0.003),
                                      child: Text(
                                        _user.username!,
                                        style: TextStyle(
                                            // fontFamily: 'Gilroy',
                                            fontSize: height * 0.029,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Text(
                                      _user.designation!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.017),
                                    ),
                                    Padding(
                                      padding:
                                          new EdgeInsets.all(height * 0.016),
                                      child: Button(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                            function:
                                                                _refreshImage,
                                                            imageVersion:
                                                                _imageVersion)));
                                          },
                                          height: height * 0.045,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.37,
                                          font: height * 0.016,
                                          text1: "Edit Profile"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Button(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CoinStatustScreen()));
                                            },
                                            width: width * 0.45,
                                            height: height * 0.056,
                                            font: height * 0.017,
                                            text1: _user.coins!.toString() +
                                                " Sinicoins",
                                            colored: false,
                                            weight: FontWeight.w500,
                                            image:
                                                'assets/images/sinicoins.png',
                                          ),
                                          Button(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RedeemCoinScreen()));
                                            },
                                            width: width * 0.45,
                                            height: height * 0.056,
                                            font: height * 0.017,
                                            weight: FontWeight.w500,
                                            text1: "Redeem Coins",
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Button(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PendingRequestScreen()));
                                            },
                                            width: width * 0.45,
                                            height: height * 0.056,
                                            font: height * 0.017,
                                            weight: FontWeight.w500,
                                            text1: "Pending Requests",
                                            colored: false,
                                          ),
                                          Button(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RequestLeave()));
                                            },
                                            width: width * 0.45,
                                            height: height * 0.056,
                                            font: height * 0.017,
                                            weight: FontWeight.w500,
                                            text1: "Request Leave",
                                            colored: false,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: width * 0.03,
                                          left: width * 0.03,
                                          bottom: height * 0.01,
                                          top: height * 0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Attendance",
                                              style: TextStyle(
                                                  fontSize: height * 0.026,
                                                  fontWeight: FontWeight.w500)),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  "View all",
                                                  style: TextStyle(
                                                      fontSize: height * 0.017,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AttendanceScreenn()));
                                                },
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_right,
                                                size: height * 0.018,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    FutureBuilder(
                                        future:
                                            AttendaceService.getAttendance(1),
                                        builder: (BuildContext ctx,
                                            AsyncSnapshot<List<AttendanceModel>>
                                                snapshot) {
                                          if (snapshot.connectionState !=
                                              ConnectionState.done) {
                                            return Container(
                                              height: height * 0.2,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Color(0xFf7DC155),
                                              )),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            return attendanceListView(
                                                height,
                                                width,
                                                snapshot.data!,
                                                snapshot.data!.length < 10
                                                    ? snapshot.data!.length
                                                    : 10,
                                                false);
                                          } else {
                                            print(snapshot.error);
                                            return Container(
                                              height: height * 0.03,
                                              child: Center(
                                                child: Text(
                                                    "No Attenndance to show"),
                                              ),
                                            );
                                          }
                                        }),
                                    SizedBox(height: height * 0.03),
                                    Image.asset(
                                      'assets/images/Digitaez1.jpg',
                                    ),
                                    SizedBox(height: height * 0.01),
                                    SvgPicture.asset(
                                      'assets/images/txt.svg',
                                    ),
                                    SizedBox(height: height * 0.15),
                                  ],
                                ),
                              ),
                              SizedBox(width: width * 0.02),
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
      ),
    );
  }
}
