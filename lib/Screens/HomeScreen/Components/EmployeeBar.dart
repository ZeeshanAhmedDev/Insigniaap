import 'package:digitaez/Models/core/EmployeeModel.dart';
import 'package:digitaez/Models/service/Employyee.dart';
import 'package:flutter/material.dart';

class EmployeeBar extends StatelessWidget {
  EmployeeBar(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: width * 0.02),
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: height * 0.025,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          FutureBuilder<List<EmployeeMonthModel>>(
              future: EmployeeService.getEmployyeOfTheMonth(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Container(
                      height: height * 0.125,
                      child: Center(child: Text("No Employee to show")));
                }
                if ((snapshot.hasData && snapshot.data!.length == 0)) {
                  print("no employee");
                  return Container(
                      height: height * 0.125,
                      child: Center(child: Text("No Employee to show")));
                }

                return snapshot.hasData
                    ? Container(
                        width: width * 0.96,
                        height: height * 0.18,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.02)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF72BAA8), Color(0xFF7EC249)]),
                          //color: Color(0xFF56c0c0),
                          //
                        ),
                        child: Card(
                            elevation: 20,
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(height * 0.02),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: height * 0.015,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.55,
                                        alignment: Alignment.topLeft,
                                        // color: Colors.amber,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            snapshot.data![0].name,
                                            style: TextStyle(
                                                fontSize: height * 0.025,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            snapshot.data![0].totalcoin
                                                    .toString() +
                                                " Digicoins",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.018),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Text(
                                    snapshot.data![0].designation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * 0.018,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Coins Rem",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                                ),
                                                Text(
                                                  snapshot.data![0].coins
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Hours Worked",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                                ),
                                                Text(
                                                  snapshot.data![0].hoursWorked
                                                      .round()
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Leave Rem",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                                ),
                                                Text(
                                                  snapshot.data![0].leaves
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Performance",
                                            style: TextStyle(
                                              fontSize: height * 0.018,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Very Good",
                                            style: TextStyle(
                                              fontSize: height * 0.02,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                        color: Color(0xFF79BE74),
                      ));
              })
        ]);
  }
}
