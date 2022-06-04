import 'dart:async';

import 'package:digitaez/Models/service/AttendanceService.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Models/core/AttendanceModel.dart';
import 'package:digitaez/Screens/ProfileScreen/Components/ScrollableButtons.dart';
import 'package:digitaez/Screens/ProfileScreen/Components/attendanceListView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> options = ["All", "Month"];

class AttendanceScreenn extends StatefulWidget {
  const AttendanceScreenn({Key? key}) : super(key: key);

  @override
  _AttendanceScreennState createState() => _AttendanceScreennState();
}

class _AttendanceScreennState extends State<AttendanceScreenn> {
  int _selectedIndex = 0;
  DateTime _selectedDated = DateTime.now();
  int _AllIndex = 1;
  List<AttendanceModel> _allItems = [];
  Future<List<AttendanceModel>>? _future1;
  bool isLoading = false;
  final _controller = ScrollController();
  bool one = true;
  bool load = true;
  initState() {
    if (one) {
      _future1 = getAll();
      load = true;
      one = false;
    }

    super.initState();
    //  controllerListner1();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<AttendanceModel>> getAll() async {
    var payload = await AttendaceService.getAttendance(_AllIndex);
    if (payload.length != 0) {
      _AllIndex++;
    } else
      load = false;
    _allItems.addAll(payload);
    setState(() {
      isLoading = false;
    });

    return _allItems;
  }

  _onSelected(int index, DateTime date) {
    setState(() => {_selectedIndex = index, _selectedDated = date});
    // _controller.jumpTo(_controller.position.minScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: appBar(
        context,
        "Attendance History",
        () {
          Navigator.pop(context);
        },
      ),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.09,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) =>
                  ScrollableButton(
                      index: index,
                      type: "Attendance",
                      selectedIndex: _selectedIndex,
                      option: options[index],
                      function: _onSelected)),
        ),
        _selectedIndex == 0
            ? FutureBuilder(
                future: _future1,
                builder: (BuildContext ctx,
                    AsyncSnapshot<List<AttendanceModel>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container(
                      height: height * 0.6,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasData) {
                    return Expanded(
                        child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              print(!isLoading);

                              if (load &&
                                  !isLoading &&
                                  _selectedIndex == 0 &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                // start loading data
                                getAll();
                                if (mounted) {
                                  setState(() {
                                    isLoading = true;
                                    Timer(
                                      Duration(microseconds: 50),
                                      () => _controller.jumpTo(
                                          _controller.position.maxScrollExtent),
                                    );
                                  });
                                }
                              }
                              return true;
                            },
                            child: SingleChildScrollView(
                              controller: _controller,
                              child: Padding(
                                padding: new EdgeInsets.symmetric(
                                    vertical: height * 0.01,
                                    horizontal: width * 0.03),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.04)),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.02,
                                      horizontal: width * 0.05,
                                    ),
                                    child: _allItems.length == 0
                                        ? Container(
                                            height: height * 0.03,
                                            child: Center(
                                                child: Text(
                                                    "No Attendance to show")),
                                          )
                                        : ConstrainedBox(
                                            constraints: BoxConstraints(
                                                minHeight: height * 0.03),
                                            child: Column(children: [
                                              ListView.builder(
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemCount: _allItems.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  height *
                                                                      0.0045),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(_allItems[
                                                                              index]
                                                                          .date),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        height *
                                                                            0.0165,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  )),
                                                              Text(
                                                                  DateFormat(
                                                                          'EEEE')
                                                                      .format(_allItems[
                                                                              index]
                                                                          .date),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        height *
                                                                            0.0165,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  )),
                                                              Text(
                                                                _allItems[index]
                                                                            .status ==
                                                                        'Attendance'
                                                                    ? 'Present'
                                                                    : ' Leave ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        height *
                                                                            0.0165,
                                                                    color: _allItems[index].status ==
                                                                            'Attendance'
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Time In: " +
                                                                    DateFormat(
                                                                            'hh:mm aa')
                                                                        .format(_allItems[index]
                                                                            .date),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      height *
                                                                          0.0165,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                            Text(
                                                                "Time Out: " +
                                                                    _allItems[
                                                                            index]
                                                                        .endDate,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      height *
                                                                          0.0165,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                          ],
                                                        ),
                                                        Divider()
                                                      ],
                                                    );
                                                  }),
                                              Container(
                                                height: isLoading ? 50.0 : 0,
                                                color: Colors.transparent,
                                                child: Center(
                                                  child:
                                                      new CircularProgressIndicator(),
                                                ),
                                              )
                                            ]),
                                          ),
                                  ),
                                ),
                              ),
                            )));
                  } else {
                    print(snapshot.error);
                    return Container(
                      height: height * 0.03,
                      child: Center(
                        child: Text("No Attenndance to show"),
                      ),
                    );
                  }
                })
            : FutureBuilder(
                future: AttendaceService.getAttendanceMonth(_selectedDated),
                builder: (BuildContext ctx,
                    AsyncSnapshot<List<AttendanceModel>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container(
                        height: height * 0.6,
                        child: Center(child: CircularProgressIndicator()));
                  }

                  if (snapshot.hasData) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: new EdgeInsets.symmetric(
                              vertical: height * 0.01,
                              horizontal: width * 0.03),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(height * 0.04)),
                              color: Colors.grey.shade300,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.02,
                                horizontal: width * 0.05,
                              ),
                              child: snapshot.data!.length == 0
                                  ? Container(
                                      height: height * 0.03,
                                      child: Center(
                                          child: Text("No Attendance to show")),
                                    )
                                  : ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minHeight: height * 0.03),
                                      child: Column(children: [
                                        ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        height * 0.0045),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(snapshot
                                                                    .data![
                                                                        index]
                                                                    .date),
                                                            style: TextStyle(
                                                              fontSize: height *
                                                                  0.0165,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            )),
                                                        Text(
                                                            DateFormat('EEEE')
                                                                .format(snapshot
                                                                    .data![
                                                                        index]
                                                                    .date),
                                                            style: TextStyle(
                                                              fontSize: height *
                                                                  0.0165,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            )),
                                                        Text(
                                                          snapshot.data![index]
                                                                      .status ==
                                                                  'Attendance'
                                                              ? 'Present'
                                                              : ' Leave ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: height *
                                                                  0.0165,
                                                              color: snapshot
                                                                          .data![
                                                                              index]
                                                                          .status ==
                                                                      'Attendance'
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Time In: " +
                                                              DateFormat(
                                                                      'hh:mm aa')
                                                                  .format(snapshot
                                                                      .data![
                                                                          index]
                                                                      .date),
                                                          style: TextStyle(
                                                            fontSize:
                                                                height * 0.0165,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      Text(
                                                          "Time Out: " +
                                                              snapshot
                                                                  .data![index]
                                                                  .endDate,
                                                          style: TextStyle(
                                                            fontSize:
                                                                height * 0.0165,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                    ],
                                                  ),
                                                  Divider()
                                                ],
                                              );
                                            }),
                                      ]),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    print(snapshot.error);
                    return Container(
                      height: height * 0.03,
                      child: Container(
                        height: height * 0.6,
                        child: Center(
                          child: Text(
                              'No Attenndance to show  for ${_selectedDated.month}'),
                        ),
                      ),
                    );
                  }
                }),
      ]),
    );
  }
}
