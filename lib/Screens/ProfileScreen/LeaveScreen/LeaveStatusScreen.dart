import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaveStatus extends StatelessWidget {
  const LeaveStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: appBar(context, "Request For Leave", () {
          Navigator.pop(context);
        }),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            'assets/images/tick.svg',
            fit: BoxFit.contain,
            height: height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Text(
              'Request Submitted',
              style: TextStyle(
                  fontSize: height * 0.03, fontWeight: FontWeight.w800),
            ),
          ),
          Text('Your Leave Request has submitted',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: height * 0.018,
                  height: height * 0.0015)),
          Text(
            'You will get notified once your application',
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: height * 0.018,
                height: height * 0.0015),
          ),
          Text(
            'gets reviewed',
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: height * 0.018,
                height: height * 0.0015),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.03),
            child: Button(
                onPressed: () {
                  Navigator.pop(context);
                },
                text1: "Back",
                font: height * 0.018,
                width: MediaQuery.of(context).size.width * 0.43,
                height: height * 0.055),
          )
        ])));
  }
}
