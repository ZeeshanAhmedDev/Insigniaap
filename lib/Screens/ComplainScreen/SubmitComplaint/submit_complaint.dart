import 'package:flutter/material.dart';

import '../../Components/Button.dart';
import '../../Components/appBar.dart';
import '../../Components/textFeild.dart';

final _subjectController = TextEditingController();
bool isLoading = false;

// myTextStyle(BuildContext context) {
//
// }

class SubmitComplaintScreen extends StatelessWidget {
  const SubmitComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final _txtStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: height * 0.023,
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar(context, "Submit Complain", () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.96,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.01),
                    textFeild(
                      context,
                      _subjectController,
                      "Enter Subject",
                      en: !isLoading,
                    ),
                    SizedBox(height: height * 0.05),
                    textDescField(
                      context,
                      _subjectController,
                      "Enter your Query",
                      en: !isLoading,
                    ),
                    SizedBox(height: height * 0.55),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                          colored: false,
                          onPressed: () {},
                          text1: "Cancel",
                          width: width * 0.4,
                          height: height * 0.055,
                          font: height * 0.018,
                        ),
                        Button(
                          onPressed: () {},
                          text1: "Submit",
                          width: width * 0.4,
                          height: height * 0.055,
                          font: height * 0.018,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Text(
// 'Subject',
// style: _txtStyle,
// ),
