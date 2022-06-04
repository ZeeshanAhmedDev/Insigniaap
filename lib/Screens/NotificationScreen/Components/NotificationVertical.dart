import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget announcementBar1(BuildContext context, String title, String description,
    index, bool isEarned,
    {String? time}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return SizedBox(
    height: height * 0.115,
    width: width * 0.82,
    child: Card(
      elevation: 5,

      //shadowColor: Colors.transparent,
      color: index == 0 ? Color(0xFFff6160) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height * 0.025),
      ),
      child: Padding(
        padding: new EdgeInsets.only(left: width * 0.03, right: width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: isEarned ? 2 : 1,
                        style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.black,
                            fontSize: height * 0.017,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.003),
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(height * 0.003),
                              child: AutoSizeText(
                                description,
                                maxLines: isEarned ? 1 : 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: height * 0.0145),
                              ),
                            ),
                          ),
                          isEarned
                              ? Text(
                                  time!,
                                  style: TextStyle(fontSize: height * 0.0145),
                                )
                              : SizedBox(
                                  width: 0,
                                  height: 0,
                                )
                        ]),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget warningBar1(BuildContext context, String type, index) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return SizedBox(
    height: height * 0.115,
    width: width * 0.96,
    child: Card(
      elevation: 3,
      //shadowColor: Colors.transparent,
      color: index == 0 ? Color(0xFFd85857) : Color(0xFF7BBF4F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height * 0.025),
      ),
      child: Row(
        children: [
          Container(
            width: type == "Alert"
                ? width * 0.145
                : type == "Coin"
                    ? width * 0.14
                    : width * 0.14,
            child: Center(
              child: SvgPicture.asset(
                type == "Alert"
                    ? 'assets/images/warning.svg'
                    : type == "Food"
                        ? 'assets/images/dish.svg'
                        : type == "Time"
                            ? 'assets/images/clock.svg'
                            : "assets/images/DGC.svg",
                fit: BoxFit.fitWidth,

                width: type == "Alert"
                    ? width * 0.1
                    : type == "Time"
                        ? width * 0.08
                        : width * 0.09,
                //scale: 0.8,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
