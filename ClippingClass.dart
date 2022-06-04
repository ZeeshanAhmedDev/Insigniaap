import 'package:flutter/material.dart';

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.85, size.width, size.height);
    // path.quadraticBezierTo(
    //     3 * size.width / 4, size.height - 23, size.width, size.height);
    // path.lineTo(size.width / 2.1, size.height * 0.85);
    // path.lineTo(size.width / 2.2, size.height * 0.85);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
