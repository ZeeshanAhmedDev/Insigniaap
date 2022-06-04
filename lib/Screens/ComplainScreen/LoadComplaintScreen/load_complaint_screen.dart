import 'package:digitaez/Screens/ComplainScreen/Helper/helper.dart';
import 'package:flutter/material.dart';
import '../../Components/appBar.dart';
import '../SubmitComplaint/submit_complaint.dart';

class LoadComplaintsScreen extends StatefulWidget {
  const LoadComplaintsScreen({Key? key}) : super(key: key);

  @override
  _LoadComplaintsScreenState createState() => _LoadComplaintsScreenState();
}

class _LoadComplaintsScreenState extends State<LoadComplaintsScreen> {
  final List<String> title = [
    'Earned 100 SNC For Coming On Time',
    'Earned 100 SNC For Coming On Time',
    'Earned 100 SNC For Coming On Time',
  ];

  final List<String> subTitle = [
    'Lorem Ipsum is simply dummy text of the.',
    'Lorem Ipsum is simply dummy text of the.',
    'Lorem Ipsum is simply dummy text of the.',
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar(context, "All Complain", () {
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
                    SizedBox(height: height * 0.02),
                    GestureDetector(
                      child: Container(
                        width: 334.89,
                        height: 47.72,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 334.89,
                              height: 47.72,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff72baa3),
                                    Color(0xff7cc051)
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 116,
                                vertical: 15,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add New Query",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubmitComplaintScreen(),
                          )),
                    ),
                    SizedBox(height: height * 0.03),
                    GestureDetector(
                      onTap: () {
                        ComplaintHelper
                            .showAlertCustomerDialogForCancelOrResolved(
                          context,
                          1,
                        );
                      },
                      child: Container(
                        width: 334.04,
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFE5E5E5).withOpacity(0.9),
                              spreadRadius: 2,
                              offset: Offset(1, 1.5),
                              blurRadius: 2,
                            )
                          ],
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.02),
                                  Text('${title.first}'),
                                  SizedBox(height: height * 0.001),
                                  Text('${subTitle.first}'),
                                ],
                              ),
                            ]),
                      ),
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
