import 'package:digitaez/Screens/ProfileScreen/LeaveScreen/RequestLeave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget leaveBar(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  return Container(
    height: height * 0.115,
    width: width * 0.96,
    color: Colors.white,
    child: InkWell(
      child: Card(
        elevation: 30,
        shadowColor: Colors.grey.shade100,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height * 0.023),
        ),
        child: Padding(
          padding: new EdgeInsets.only(left: width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Register Leave",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: height * 0.017,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Feeling Sick? or need a break?",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.green, fontSize: height * 0.015),
                        ),
                      )
                    ]),
              ),
              SvgPicture.asset(
                'assets/images/markGreen.svg',
                fit: BoxFit.fitHeight,
                height: height * 0.1,
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RequestLeave()));
        //}
        //  );
      },
    ),
  );
}
