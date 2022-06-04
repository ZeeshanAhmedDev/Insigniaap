import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Screens/Components/textFeild.dart';
import 'package:digitaez/Screens/DishScreen/AddDishSCreen/RequestStatus.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class AddDish extends StatefulWidget {
  const AddDish({Key? key}) : super(key: key);

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  final _name = TextEditingController();
  final _recipe = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar(context, "Request Dish Addition", () {
              Navigator.pop(context);
            }),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.94,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: new EdgeInsets.all(width * 0.02),
                          child: Text(
                            "Dish Name",
                            style: TextStyle(
                                fontSize: height * 0.02,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        textFeild(
                          context,
                          _name,
                          "Enter Dish Name Here",
                          width: width * 0.94,
                        ),
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: new EdgeInsets.all(width * 0.02),
                          child: Text(
                            "Recipe",
                            style: TextStyle(
                                fontSize: height * 0.02,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        textFeild(
                          context,
                          _recipe,
                          "Enter Recipe Here(Not Mandatory)",
                          round: height * 0.04,
                          maxLine: 10,
                          width: width * 0.96,
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Button(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text1: "Cancel",
                                  colored: false,
                                  font: height * 0.018,
                                  width: width * 0.43,
                                  height: height * 0.055),
                              Button(
                                  onPressed: () {
                                    if (_name.text.isNotEmpty) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RequestStatus()));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Dish Name is must",
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                    }
                                  },
                                  text1: "Submit",
                                  font: height * 0.018,
                                  width: width * 0.43,
                                  height: height * 0.055)
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            )));
  }
}
