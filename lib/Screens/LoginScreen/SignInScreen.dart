import 'package:digitaez/Models/core/UserModel.dart';
import 'package:digitaez/Models/service/AuthService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/BottomNavBar.dart';
import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Screens/Components/textFeild.dart';
import 'package:digitaez/Screens/LoginScreen/ForgotPassword.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool isloading = false;

  RegExp regExp = new RegExp(
    r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])",
    caseSensitive: true,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DoubleBack(
      message: "Press back again to close",
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.27,
                      ),
                      SvgPicture.asset(
                        'assets/images/Insignia.svg',
                        fit: BoxFit.contain,
                        width: width * 0.4,
                        height: height * 0.17,
                        // scale: 0.8,
                      ),
                      // Image.asset("assets/images/office.gif",
                      //    width: width * 0.8),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      textFeild(
                        context,
                        _email,
                        "Enter your Email",
                        en: !isloading,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFeildPassword(
                        controller: _password,
                        en: !isloading,
                      ),
                      SizedBox(
                        height: height * 0.085,
                      ),
                      Button(
                        onPressed: (() async {
                          if (!isloading) {
                            if (regExp.hasMatch(_email.text) &&
                                _password.text.length >= 6) {
                              setState(() {
                                isloading = true;
                              });
                              var response = await AuthSevice.getToken(
                                  _email.text, _password.text);
                              print(response);
                              if (response["success"]) {
                                UserModel user =
                                    UserModel.fromJson(response["user"]);
                                if (user.role == "employee" ||
                                    user.role == "supervisor") {
                                  Provider.of<UserNotifier>(context,
                                          listen: false)
                                      .updateUserObject(user);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBar()));
                                  setState(() {
                                    _email.text = "";
                                    _password.text = "";
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      backgroundColor: Colors.red,
                                      msg:
                                          "only employee and supervisor can login");
                                }
                              }
                              setState(() {
                                isloading = false;
                              });
                            } else if (_email.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Email missing",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: height * 0.018);
                            } else if (_password.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Password missing",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: height * 0.018);
                            } else if (!regExp.hasMatch(_email.text)) {
                              Fluttertoast.showToast(
                                  msg: "Please provide valid email",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: height * 0.018);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Pasword length should be atlease of 6 digit",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: height * 0.018);
                            }
                          }
                        }),
                        text1: "Sign In",
                        font: height * 0.018,
                        width: width * 0.4,
                        height: height * 0.055,
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      isloading
                          ? SizedBox(
                              height: height * 0.04,
                              child: CircularProgressIndicator(
                                color: Color(0xFF7EC349),
                              ))
                          : SizedBox(
                              height: height * 0.04,
                            ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: (() {
                              if (!isloading) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()),
                                );

                                setState(() {
                                  _email.text = "";
                                  _password.text = "";
                                });
                              }
                            }),
                            child: Padding(
                              padding: EdgeInsets.all(height * 0.005),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xFF7EC349),
                                  fontSize: height * 0.019,
                                ),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
