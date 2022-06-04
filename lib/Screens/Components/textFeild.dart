import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textFeild(
    BuildContext context, TextEditingController controller, String hint,
    {double width = 0,
    double font = 0,
    bool en = true,
    bool isNumber = false,
    int maxLine = 1,
    double round = 0}) {
  double width1 = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return SizedBox(
    width: width == 0 ? width1 * 0.85 : width,
    child: TextField(
      controller: controller,
      maxLines: maxLine,
      keyboardType: isNumber
          ? TextInputType.number
          : hint == "Enter your Email"
              ? TextInputType.emailAddress
              : TextInputType.name,
      inputFormatters: isNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      style: TextStyle(
          fontSize: font == 0 ? height * 0.018 : font,
          color: en == true ? Colors.black : Colors.grey.shade500),
      decoration: InputDecoration(
        enabled: en,
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey.shade500,
            textBaseline: TextBaseline.alphabetic,
            fontSize: font == 0 ? height * 0.018 : font),
        fillColor: en == true ? Colors.grey.shade200 : Colors.grey.shade100,
        filled: true,
        // isDense: true,
        contentPadding: EdgeInsets.only(
          top: height * 0.03,
          bottom: 0,
          right: height * 0.04,
          left: round != 0 ? width1 * 0.06 : width1 * 0.07,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius:
              BorderRadius.circular(round != 0 ? round : height * 0.15),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(round != 0 ? round : height * 0.15)),
      ),
    ),
  );
}

Widget textDescField(
    BuildContext context, TextEditingController controller, String hint,
    {double width = 0,
    double font = 0,
    bool en = true,
    bool isNumber = false,
    int maxLine = 5,
    double round = 30}) {
  double width1 = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return SizedBox(
    width: width == 0 ? width1 * 0.85 : width,
    child: TextField(
      controller: controller,
      maxLines: maxLine,
      keyboardType: isNumber
          ? TextInputType.number
          : hint == "Enter your Email"
              ? TextInputType.emailAddress
              : TextInputType.name,
      inputFormatters: isNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      style: TextStyle(
          fontSize: font == 0 ? height * 0.018 : font,
          color: en == true ? Colors.black : Colors.grey.shade500),
      decoration: InputDecoration(
        enabled: en,
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey.shade500,
            textBaseline: TextBaseline.alphabetic,
            fontSize: font == 0 ? height * 0.018 : font),
        fillColor: en == true ? Colors.grey.shade200 : Colors.grey.shade100,
        filled: true,
        // isDense: true,
        contentPadding: EdgeInsets.only(
          top: height * 0.03,
          bottom: 0,
          right: height * 0.04,
          left: round != 0 ? width1 * 0.06 : width1 * 0.07,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius:
              BorderRadius.circular(round != 0 ? round : height * 0.15),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(round != 0 ? round : height * 0.15)),
      ),
    ),
  );
}

class TextFeildPassword extends StatefulWidget {
  final TextEditingController controller;
  double width;
  double font;
  bool en;

  String hint;
  TextFeildPassword(
      {Key? key,
      required this.controller,
      this.width = 0,
      this.en = true,
      this.font = 0,
      this.hint = "Enter your Password"})
      : super(key: key);

  @override
  _TextFeildPasswordState createState() => _TextFeildPasswordState();
}

class _TextFeildPasswordState extends State<TextFeildPassword> {
  bool _passEnable = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: widget.width == 0 ? width * 0.85 : widget.width,
      child: TextField(
        controller: widget.controller,
        style: TextStyle(
            fontSize: widget.font == 0 ? height * 0.018 : widget.font),
        decoration: InputDecoration(
          hintText: widget.hint,
          enabled: widget.en,
          fillColor:
              widget.en == true ? Colors.grey.shade200 : Colors.grey.shade100,
          hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: widget.font == 0 ? height * 0.018 : widget.font),
          filled: true,
          contentPadding: EdgeInsets.only(
              top: height * 0.03,
              bottom: 0,
              right: height * 0.04,
              left: width * 0.07),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(height * 0.15),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(height * 0.15)),
          suffixIcon: IconButton(
              icon: Icon(
                _passEnable ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey.shade500,
                size: height * 0.025,
              ),
              onPressed: () {
                setState(() {
                  _passEnable = !_passEnable;
                });
              }),
        ),
        obscureText: !_passEnable,
      ),
    );
  }
}
