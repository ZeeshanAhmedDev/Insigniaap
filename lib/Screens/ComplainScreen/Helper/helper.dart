import 'package:flutter/material.dart';

class ComplaintHelper {
  static showAlertCustomerDialogForCancelOrResolved(
      BuildContext context, int index) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height * 0.02,
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Stack(
                children: [
                  ///Compalin Tititle
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.width * 0.04,
                    child: SizedBox(
                      child: Text(
                        'Please Select any one',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontFamily: 'VisbycfBold',
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.visible,
                        maxLines: 5,
                        softWrap: true,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.04,
                    child: SizedBox(
                      child: Text(
                        'help procedure from below',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontFamily: 'VisbycfBold',
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.visible,
                        maxLines: 5,
                        softWrap: true,
                      ),
                    ),
                  ),

                  ///Status
                  // Positioned(
                  //   top: MediaQuery.of(context).size.height * 0.025,
                  //   left: MediaQuery.of(context).size.width * 0.6,
                  //   child: Text(
                  //     MyComplaintsModel.complaints[index].status,
                  //     style: TextStyle(
                  //       color: MyComplaintsModel.complaints[index].status ==
                  //                   "Pending" ||
                  //               MyComplaintsModel.complaints[index].status ==
                  //                   "pending"
                  //           ? Color(0xFF005E7B)
                  //           : MyComplaintsModel.complaints[index].status ==
                  //                       "Cancelled" ||
                  //                   MyComplaintsModel
                  //                           .complaints[index].status ==
                  //                       "cancelled"
                  //               ? Colors.red
                  //               : kSplashScreenColor,
                  //       fontSize: MediaQuery.of(context).size.width * 0.026,
                  //       fontFamily: 'VisbycfRegular',
                  //     ),
                  //     overflow: TextOverflow.visible,
                  //   ),
                  // ),

                  ///day from date
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.045,
                    left: MediaQuery.of(context).size.width * 0.04,
                    child: Text(
                      '''Dummy text is Dummy text is Dummy text is''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontFamily: 'VisbycfMedium',
                      ),
                    ),
                  ),

                  ///Won or loss marker
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.045,
                    left: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      '''Dummy text is Dummy text is Dummy text is''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.026,
                        fontFamily: 'VisbycfRegular',
                      ),
                    ),
                  ),

                  ///Correct
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.09,
                    left: MediaQuery.of(context).size.width * 0.04,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        '''Dummy text is Dummy text is Dummy text is''',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.013,
                          fontFamily: 'VisbycfRegular',
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),

                  ///Back Button
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.155,
                    left: MediaQuery.of(context).size.width * 0.23,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.016,
                            fontFamily: 'VisbycfBold',
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.028,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff47BC61).withOpacity(0.47),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // insetPadding: EdgeInsets.all(33),
            // clipBehavior: Clip.antiAliasWithSaveLayer,
          );
        });
  }
}
