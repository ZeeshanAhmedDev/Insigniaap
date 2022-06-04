import 'package:digitaez/Screens/NotificationScreen/Notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget announcementBar(BuildContext context, String title, String description) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return InkWell(
    child: SizedBox(
      height: height * 0.1,
      width: width * 0.82,
      child: Card(
        elevation: 6,

        //shadowColor: Colors.transparent,
        color: Color(0xFFff6160),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height * 0.025),
        ),
        child: Padding(
          padding: new EdgeInsets.only(left: width * 0.03, right: width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          title,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.017,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          description,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.015),
                        ),
                      )
                    ]),
              ),
              SvgPicture.asset(
                'assets/images/arrowright.svg',
                fit: BoxFit.fitHeight,
                height: height * 0.1,
              ),
            ],
          ),
        ),
      ),
    ),
    onTap: () {
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => NotificationScreen()));
    },
  );
}

Widget warningBar(BuildContext context, String type) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return SizedBox(
    height: height * 0.1,
    width: width * 0.96,
    child: Card(
      elevation: 3,
      //shadowColor: Colors.transparent,
      color: Color(0xFFd85857),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height * 0.025),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.14,
            child: Center(
              child: SvgPicture.asset(
                type == "Alert"
                    ? 'assets/images/warning.svg'
                    : type == "Food"
                        ? 'assets/images/dish.svg'
                        : type == "Time"
                            ? 'assets/images/clock.svg'
                            : "assets/images/DGC.svg",
                fit: BoxFit.contain,
                width: type == "Alert"
                    ? width * 0.09
                    : type == "Time"
                        ? width * 0.07
                        : width * 0.08,
                height: type == "Food" ? height * 0.026 : height * 0.035,
                //scale: 0.8,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
