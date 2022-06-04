import 'package:digitaez/Screens/Components/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/email.svg',
                height: height * 0.08,
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Email Sent",
                style: TextStyle(
                    fontSize: height * 0.032, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: height * 0.015),
              Text(
                "Instruction to Reset your Password",
                style: TextStyle(
                    fontSize: height * 0.018, color: Colors.grey.shade800),
              ),
              Text(
                "Has Been sent to your Email Address",
                style: TextStyle(
                    fontSize: height * 0.018, color: Colors.grey.shade800),
              ),
              SizedBox(height: height * 0.03),
              Button(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                text1: "Back",
                width: width * 0.4,
                height: height * 0.055,
                font: height * 0.018,
              )
            ],
          )
        ],
      ),
    );
  }
}
