import 'package:digitaez/Models/core/AttendanceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget attendanceListView(double height, double width,
    List<AttendanceModel> Attendance, length, bool isAttendance) {
  return Padding(
    padding: new EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: isAttendance == true ? width * 0.03 : width * 0.01),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(height * 0.04)),
        color: Colors.grey.shade300,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.05,
        ),
        child: length == 0
            ? Container(
                height: height * 0.03,
                child: Center(child: Text("No Attendance to show")),
              )
            : ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: height * 0.03, maxHeight: height * 0.9),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * 0.0045),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(Attendance[index].date),
                                    style: TextStyle(
                                      fontSize: height * 0.0165,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                    DateFormat('EEEE')
                                        .format(Attendance[index].date),
                                    style: TextStyle(
                                      fontSize: height * 0.0165,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  Attendance[index].status == 'Attendance'
                                      ? 'Present'
                                      : ' Leave ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * 0.0165,
                                      color: Attendance[index].status ==
                                              'Attendance'
                                          ? Colors.green
                                          : Colors.red),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Time In: " +
                                      DateFormat('hh:mm aa')
                                          .format(Attendance[index].date),
                                  style: TextStyle(
                                    fontSize: height * 0.0165,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text("Time Out: " + Attendance[index].endDate,
                                  style: TextStyle(
                                    fontSize: height * 0.0165,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                          Divider()
                        ],
                      );
                    }),
              ),
      ),
    ),
  );
}
