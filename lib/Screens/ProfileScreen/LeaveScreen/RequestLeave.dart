import 'package:digitaez/Models/core/UserModel.dart';
import 'package:digitaez/Models/service/AuthService.dart';
import 'package:digitaez/Models/service/leaveService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Screens/Components/textFeild.dart';
import 'package:digitaez/Screens/ProfileScreen/LeaveScreen/LeaveStatusScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RequestLeave extends StatefulWidget {
  const RequestLeave({Key? key}) : super(key: key);

  @override
  _RequestLeaveState createState() => _RequestLeaveState();
}

class _RequestLeaveState extends State<RequestLeave> {
  final _reason = TextEditingController();
  String _attachment = "No Document Selected";
  String? _selectedType;
  String _range = "Select Date Duration";
  DateTime? start;
  DateTime? end;
  String _path = "";
  int _count = 0;
  FilePickerResult? result;
  bool isLoading = false;
  Future? _future1;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      start = args.value.startDate;
      end = args.value.endDate ?? args.value.startDate;
      _range = DateFormat('dd MMM').format(args.value.startDate).toString() +
          ' - ' +
          DateFormat('dd MMM yyyy').format(end!).toString();

      _count = getDifferenceWithoutWeekends(args.value.startDate, end!);
    });
  }

  int getDifferenceWithoutWeekends(DateTime startDate, DateTime endDate) {
    int nbDays = 0;
    DateTime currentDay = startDate;
    endDate = endDate.add(Duration(days: 1));
    while (currentDay.isBefore(endDate)) {
      if (currentDay.weekday == DateTime.saturday ||
          currentDay.weekday == DateTime.sunday) {
        nbDays += 0;
      } else
        nbDays += 1;
      currentDay = currentDay.add(Duration(days: 1));
    }
    return nbDays;
  }

  @override
  void initState() {
    // TODO: implement initState
    _future1 = myfunc();
  }

  Future<Map<String, dynamic>> myfunc() async {
    var response = await AuthSevice.getMe();
    if (response["success"]) {
      Provider.of<UserNotifier>(context, listen: false)
          .updateLeave(response["data"]);
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserNotifier>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    PlatformFile? fileSelect;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: appBar(context, "Request For Leave", () {
            Navigator.pop(context);
          }),
          body: FutureBuilder(
              future: _future1,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFF7DC24C),
                  ));
                }

                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.96,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.02),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * 0.007,
                                              left: width * 0.03),
                                          child: new RichText(
                                            text: new TextSpan(
                                              style: new TextStyle(
                                                  fontSize: height * 0.02,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                              children: <TextSpan>[
                                                new TextSpan(
                                                    text: 'Leave Type'),
                                                new TextSpan(
                                                  text: ' *',
                                                  style: new TextStyle(
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.3,
                                          height: height * 0.057,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                                height * 0.1),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.025,
                                                left: width * 0.05),
                                            child: Center(
                                              child: DropdownButton<String>(
                                                items: <String>[
                                                  'Casual',
                                                  'Sick',
                                                  'Parental'
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                      value,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontSize:
                                                              height * 0.017),
                                                    ),
                                                  );
                                                }).toList(),
                                                isExpanded: true,
                                                iconEnabledColor:
                                                    Colors.grey.shade500,
                                                underline: SizedBox(),
                                                hint: Text(
                                                  'Type',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontSize: height * 0.017),
                                                ),
                                                value: _selectedType,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedType = newValue;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * 0.007,
                                              left: width * 0.03),
                                          child: new RichText(
                                            text: new TextSpan(
                                              style: new TextStyle(
                                                  fontSize: height * 0.02,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                              children: <TextSpan>[
                                                new TextSpan(text: 'Duration'),
                                                new TextSpan(
                                                  text: ' *',
                                                  style: new TextStyle(
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: Container(
                                            width: width * 0.62,
                                            height: height * 0.057,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.1),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: width * 0.01,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.007),
                                                    child: SvgPicture.asset(
                                                      'assets/images/calender.svg',
                                                      fit: BoxFit.contain,
                                                      height: height * 0.055,
                                                    ),
                                                  ),
                                                  Text(
                                                    _range,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize:
                                                            height * 0.016),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey.shade500,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            showGeneralDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                barrierLabel:
                                                    MaterialLocalizations.of(
                                                            context)
                                                        .modalBarrierDismissLabel,
                                                barrierColor: Colors.black54,
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 500),
                                                pageBuilder: (BuildContext
                                                        buildContext,
                                                    Animation animation,
                                                    Animation
                                                        secondaryAnimation) {
                                                  return AlertDialog(
                                                      title: Text(
                                                        'Select Date Interval',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      content: Container(
                                                        width: width / 1.3,
                                                        height: 300,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                                height: 250,
                                                                child: Card(
                                                                    child:
                                                                        SfDateRangePicker(
                                                                  enablePastDates:
                                                                      true,
                                                                  selectionMode:
                                                                      DateRangePickerSelectionMode
                                                                          .range,
                                                                  view:
                                                                      DateRangePickerView
                                                                          .month,
                                                                  onSelectionChanged:
                                                                      _onSelectionChanged,
                                                                  startRangeSelectionColor:
                                                                      Color(
                                                                          0xFF7EC249),
                                                                  endRangeSelectionColor:
                                                                      Color(
                                                                          0xFF7EC249),
                                                                  selectionTextStyle:
                                                                      const TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                  rangeSelectionColor:
                                                                      Color(
                                                                          0xFF72BAA8),
                                                                  monthViewSettings:
                                                                      DateRangePickerMonthViewSettings(
                                                                          weekendDays: <
                                                                              int>[
                                                                        DateTime
                                                                            .sunday,
                                                                        DateTime
                                                                            .saturday
                                                                      ]),
                                                                ))),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                MaterialButton(
                                                                  child: Text(
                                                                      "Cancel"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                MaterialButton(
                                                                  child: Text(
                                                                      "OK"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ));
                                                });
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: height * 0.02),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.01,
                                      bottom: height * 0.007,
                                      left: width * 0.03),
                                  child: new RichText(
                                    text: new TextSpan(
                                      style: new TextStyle(
                                          fontSize: height * 0.02,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: <TextSpan>[
                                        new TextSpan(text: 'Reason'),
                                        new TextSpan(
                                          text: ' *',
                                          style:
                                              new TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      textFeild(
                                          context, _reason, "Type Reason Here",
                                          round: height * 0.03,
                                          maxLine: 6,
                                          width: width * 0.96,
                                          font: height * 0.017),
                                      SvgPicture.asset(
                                        'assets/images/reason.svg',
                                        fit: BoxFit.contain,
                                        height: height * 0.055,
                                      )
                                    ]),
                                SizedBox(height: height * 0.02),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.01, left: width * 0.03),
                                  child: new RichText(
                                    text: new TextSpan(
                                      style: new TextStyle(
                                          fontSize: height * 0.02,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: 'Attach Relevant Document'),
                                        new TextSpan(
                                          text: (_selectedType == "Sick" &&
                                                  _count >= 2)
                                              ? ' *'
                                              : '',
                                          style:
                                              new TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.6,
                                        height: height * 0.057,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                              height * 0.1),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.007),
                                              child: SvgPicture.asset(
                                                'assets/images/attached.svg',
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              _attachment,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: height * 0.016),
                                            ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: InkWell(
                                          child: SvgPicture.asset(
                                            'assets/images/attach.svg',
                                            fit: BoxFit.contain,
                                            height: height * 0.08,
                                            width: width * 0.2,
                                          ),
                                          onTap: () async {
                                            result = await FilePicker.platform
                                                .pickFiles();

                                            if (result != null) {
                                              // File filePath =
                                              //     File(result!.files.single.path!);
                                              fileSelect = result!.files.first;

                                              setState(() {
                                                _attachment = fileSelect!.name;
                                                _path = fileSelect!.path;
                                              });
                                              // print(file.name);
                                              // print(file.extension);
                                              // print(file.path);
                                              // print(filePath);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Cancelled by user",
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white);
                                            }
                                          },
                                        ),
                                      ),
                                    ]),
                                // Button(
                                //     onPressed: () {},
                                //     text1: "Attach",
                                //     height: 45,
                                //     shadow: false,
                                //     width: width * 0.3)

                                SizedBox(height: height * 0.04),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.4,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: new RichText(
                                          text: new TextSpan(
                                            style: new TextStyle(
                                                fontSize: height * 0.02,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text: 'Number of Leave'),
                                              new TextSpan(
                                                text: ' *',
                                                style: new TextStyle(
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // textFeild(context, number, "Enter Number",
                                    //     isNumber: true,
                                    //     width: width * 0.5,
                                    //     font: height * 0.016),
                                    Container(
                                        width: width * 0.5,
                                        height: height * 0.057,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                              height * 0.1),
                                        ),
                                        child: Center(
                                          child: Text(_count.toString(),
                                              style: TextStyle(
                                                fontSize: height * 0.016,
                                                color: Colors.grey.shade500,
                                              )),
                                        ))
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.4,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: new RichText(
                                          text: new TextSpan(
                                            style: new TextStyle(
                                                fontSize: height * 0.02,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text: 'Leave Remaining'),
                                              new TextSpan(
                                                text: ' *',
                                                style: new TextStyle(
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: width * 0.5,
                                        height: height * 0.057,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                              height * 0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                              model
                                                  .getuser()
                                                  .leaves!
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: height * 0.016,
                                                color: Colors.grey.shade500,
                                              )),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Container(
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Button(
                                          onPressed: () {
                                            if ((!isLoading))
                                              Navigator.pop(context);
                                          },
                                          text1: "Cancel",
                                          colored: false,
                                          font: height * 0.018,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          height: height * 0.055),
                                      Button(
                                          onPressed: () async {
                                            if (!isLoading) {
                                              if (_selectedType != null &&
                                                  _reason.text.isNotEmpty &&
                                                  ((_selectedType == "Sick" &&
                                                          _count >= 2 &&
                                                          _attachment !=
                                                              "No Document Selected") ||
                                                      (_selectedType ==
                                                              "Sick" &&
                                                          _count < 2) ||
                                                      _selectedType !=
                                                          "Sick") &&

                                                  // _attachment !=
                                                  //     "No Document Selected" &&
                                                  _count != 0 &&
                                                  _count <=
                                                      model.getuser().leaves!) {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                bool sent = await LeaveService
                                                    .registerLeave(
                                                        _selectedType!,
                                                        _reason.text,
                                                        _path,
                                                        _count,
                                                        start!,
                                                        end!);
                                                setState(() {
                                                  isLoading = false;
                                                });

                                                Navigator.pop(context);
                                                if (sent) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LeaveStatus()));
                                                }
                                              } else if (_count >
                                                  model.getuser().leaves!) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Requested Leave Cant be greter than Remaining Leaves",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.red);
                                              } else if (_selectedType ==
                                                  null) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please select type of leave",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.red);
                                              } else if (_reason.text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please enter reason of leave",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.red);
                                              } else if (_attachment ==
                                                  "No Document Selected") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please add an attachment",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.red);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Please add Duration",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.red);
                                              }
                                            }
                                          },
                                          text1: "Submit",
                                          font: height * 0.018,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          height: height * 0.055)
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                isLoading
                                    ? Center(
                                        child: Container(
                                            child: CircularProgressIndicator(
                                          color: Color(0xFF7DC24C),
                                        )),
                                      )
                                    : SizedBox(height: height * 0.03),
                                SizedBox(height: height * 0.02),
                              ]),
                        ),
                      ],
                    ),
                  );
                } else
                  return Container(
                    height: height * 0.6,
                    child: Center(child: Text("No Requests to show")),
                  );
              }),
        ));
  }
}
