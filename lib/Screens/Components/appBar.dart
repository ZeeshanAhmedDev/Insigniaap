import 'package:flutter/material.dart';

PreferredSizeWidget appBar(
    BuildContext context, String title, GestureTapCallback onPressed,
    {bool colored = true, bool}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.024,
          color: Colors.black,
          fontWeight: FontWeight.w400),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: GestureDetector(
      onTap: onPressed,
      child: Icon(
        Icons.arrow_back,
        size: MediaQuery.of(context).size.height * 0.03,
        color:
            colored ? Color(0xFF7BBF4F) : Colors.white, // add custom icons also
      ),
    ),
  );
}
