import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardBar(BuildContext context, String title, String description) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Container(
    height: height * 0.102,
    // width: width * 0.355,
    width: width * 0.8,
    child: Card(
      elevation: 3,
      //shadowColor: Colors.transparent,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height * 0.023),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: new EdgeInsets.symmetric(vertical: height * 0.002),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: height * 0.0165, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.symmetric(vertical: height * 0.002),
                  child: Container(
                    width: width * 0.29,
                    child: Text(
                      description,
                      maxLines: 1,
                      style: TextStyle(fontSize: height * 0.0143),
                    ),
                  ),
                )
              ]),
        ],
      ),
    ),
  );
}

Widget cardImageBar(BuildContext context, String image) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Card(
    elevation: 3,
    color: Colors.transparent,
    //shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(height * 0.023),
    ),
    child: Container(
      height: height * 0.09,
      //  width: width * 0.448,
      width: width * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Color(0xFF71BAA8), Color(0xFF7EC249)]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.12,
            child: Center(
              child: SvgPicture.asset(
                image,
                fit: BoxFit.contain,
                width: width * 0.07,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
