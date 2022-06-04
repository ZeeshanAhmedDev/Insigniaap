import 'package:digitaez/Models/service/AuthService.dart';
import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Screens/Components/textFeild.dart';
import 'package:digitaez/Screens/LoginScreen/EmailSentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();
  bool isloading = false;
  RegExp regExp = new RegExp(
    r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])",
    caseSensitive: true,
  );
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/lock.svg',
                        height: height * 0.1,
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: height * 0.032,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: height * 0.015),
                      Text(
                        "Enter your Email address for",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            color: Colors.grey.shade800),
                      ),
                      Text(
                        "Instructions to be sent",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            color: Colors.grey.shade800),
                      ),
                      SizedBox(height: height * 0.02),
                      textFeild(context, _email, "Enter your Email",
                          en: !isloading),
                      SizedBox(height: height * 0.02),
                      isloading
                          ? SizedBox(
                              height: height * 0.04,
                              child: CircularProgressIndicator(
                                color: Color(0xFF7EC349),
                              ))
                          : SizedBox(
                              height: height * 0.04,
                            ),
                      SizedBox(height: height * 0.02),
                      Button(
                        onPressed: () async {
                          if (_email.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Email missing",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (!regExp.hasMatch(_email.text)) {
                            Fluttertoast.showToast(
                                msg: "Please provide valid email",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: height * 0.018);
                          } else {
                            setState(() {
                              isloading = true;
                            });
                            var response =
                                await AuthSevice.forgotPassword(_email.text);
                            if (response)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailSentScreen()),
                              );
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                        text1: "Send",
                        width: width * 0.4,
                        height: height * 0.055,
                        font: height * 0.018,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
