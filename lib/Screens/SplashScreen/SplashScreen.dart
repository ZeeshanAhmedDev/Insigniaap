import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:digitaez/Models/core/UserModel.dart';
import 'package:digitaez/Models/service/AuthService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/BottomNavBar.dart';
import 'package:digitaez/Screens/LoginScreen/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  Future checkFirstSeen() async {
    Timer(new Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = (prefs.getString('token') ?? "");
      if (token != "") {
        print(token);
        print("token present");
        var response = await AuthSevice.getMe();
        if (response["success"]) {
          print("right token");
          UserModel user = UserModel.fromJson(response["data"]);
          if (user.role == "employee" || user.role == "supervisor") {
            Provider.of<UserNotifier>(context, listen: false)
                .updateUserObject(user);
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (context) => new BottomNavBar()));
          } else {
            Fluttertoast.showToast(
                msg: "Admin or SuperAdmin cant login",
                backgroundColor: Colors.red);
            prefs.clear();
            Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => new Signin()));
          }
        } else {
          //    print("wrong token");
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new Signin()));
        }
      } else {
        //    print("no token");
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new Signin()));
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Container(
          width: width,
          height: height,
          child: Center(
            child: SvgPicture.asset(
              'assets/images/Insignia.svg',
              fit: BoxFit.contain,
              width: width * 0.4,
              height: height * 0.2,
              // scale: 0.8,
            ),
          ),
        ),
        Positioned(
            top: height * 0.02,
            right: -width * 0.1,
            child: Transform.rotate(
              angle: -3.142 / 5.0,
              child: Container(
                  width: width * 0.5,
                  height: height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(width * 0.12),
                      topLeft: Radius.circular(width * 0.12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFddedf7),
                        blurRadius: 2.0,
                        spreadRadius: 4.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF7DC249), Color(0xFF7DC249)]),
                  )),
            )),
        Positioned(
          top: height * 0.65,
          right: width * 0.46,
          child: CircularProgressIndicator(
              color: Color(
            0xFF7DC249,
          )),
        ),
        Positioned(
            bottom: height * 0.22,
            right: -width * 0.3,
            child: Transform.rotate(
              angle: -3.142 / 5.0,
              child: Container(
                  width: width * 0.8,
                  height: height * 0.09,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width * 0.12),
                        topLeft: Radius.circular(width * 0.12),
                        //topRight: Radius.circular(40),
                        //bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(color: Color(0xFF7EC249)))),
            )),
        Positioned(
            top: height * 0.13,
            left: -width * 0.15,
            child: Transform.rotate(
              angle: -0.628,
              child: Container(
                  width: width * 0.5,
                  height: height * 0.09,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(width * 0.12),
                        topRight: Radius.circular(width * 0.12),
                        //topRight: Radius.circular(40),
                      ),
                      border: Border.all(color: Color(0xFF1379B6)))),
            )),
        Positioned(
            left: -width * 0.2,
            bottom: height * 0.2,
            child: Transform.rotate(
              angle: -0.62,
              child: Container(
                  width: width * 0.5,
                  height: height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(width * 0.12),
                      topRight: Radius.circular(width * 0.12),
                      //topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFddedf7),
                        blurRadius: 2.0,
                        spreadRadius: 4.0,
                        offset: Offset(0, -0),
                      )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF71BAA8), Color(0xFF7EC249)]),
                  )),
            ))
      ]),
    );
  }
}
