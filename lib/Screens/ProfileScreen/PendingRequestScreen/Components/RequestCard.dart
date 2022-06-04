import 'package:auto_size_text/auto_size_text.dart';
import 'package:digitaez/Models/core/LeaveRequestModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;
  final index;
  final last;
  final isloading;
  const RequestCard(
      {Key? key,
      required this.request,
      required this.isloading,
      required this.index,
      required this.last})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.015, vertical: height * 0.01),
            child: InkWell(
              child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(height * 0.02)),
                  ),
                  child: Container(
                    width: width * 0.96,
                    height: height * 0.12,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.035, vertical: height * 0.01),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  request.days.toString() +
                                      " Day Leave Application",
                                  style: TextStyle(fontSize: height * 0.0165),
                                ),
                                Text(request.status,
                                    style: TextStyle(
                                        fontSize: height * 0.0168,
                                        color: request.status == "Pending"
                                            ? Colors.yellow.shade600
                                            : request.status == "Approved"
                                                ? Colors.green
                                                : Colors.red))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.008),
                                      child: Text(
                                        DateFormat('dd MMMM yyyy')
                                            .format(request.startDate),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.022),
                                      ),
                                    ),
                                    Text(
                                      request.type,
                                      style:
                                          TextStyle(fontSize: height * 0.0165),
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  'assets/images/slide.svg',
                                  fit: BoxFit.fitHeight,
                                  height: height * 0.033,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              onTap: () {
                showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black45,
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (BuildContext buildContext,
                        Animation animation, Animation secondaryAnimation) {
                      return Center(
                        child: Container(
                          width: width / 1.25,
                          height: height / 2.5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(height * 0.03))),
                          padding: EdgeInsets.all(height * 0.023),
                          child: Scaffold(
                            backgroundColor: Colors.white,
                            body: Column(
                              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              "Start Date:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              "End Date:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              "CreatedAt:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              "Number of Days:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              "Leave type:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              "Leave Status:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              "Reason:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6),
                                              child: Text(
                                                DateFormat('dd MMMM yyyy')
                                                    .format(request.startDate),
                                                style: TextStyle(
                                                  fontSize: height * 0.017,
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(
                                              DateFormat('dd MMMM yyyy')
                                                  .format(request.endDate),
                                              style: TextStyle(
                                                fontSize: height * 0.017,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6),
                                              child: Text(
                                                DateFormat('dd MMMM yyyy')
                                                    .format(request.createAt),
                                                style: TextStyle(
                                                  fontSize: height * 0.017,
                                                ),
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6),
                                              child: Text(
                                                request.days.toString(),
                                                style: TextStyle(
                                                  fontSize: height * 0.017,
                                                ),
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6),
                                              child: Text(request.type,
                                                  style: TextStyle(
                                                    fontSize: height * 0.017,
                                                  ))),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 6),
                                            child: Text(request.status,
                                                style: TextStyle(
                                                    fontSize: height * 0.017,
                                                    color: request.status ==
                                                            "Pending"
                                                        ? Colors.yellow.shade600
                                                        : request.status ==
                                                                "Approved"
                                                            ? Colors.green
                                                            : Colors.red)),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6),
                                              child: Container(
                                                width: width / 2.75,
                                                child: AutoSizeText(
                                                  request.reason,
                                                  maxLines: 6,
                                                  style: TextStyle(
                                                    fontSize: height * 0.0165,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            )),
        index == last - 1
            ? Container(
                height: isloading ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 0,
              ),
        SizedBox(height: index == last - 1 ? 70 : 0),
      ],
    );
  }
}
