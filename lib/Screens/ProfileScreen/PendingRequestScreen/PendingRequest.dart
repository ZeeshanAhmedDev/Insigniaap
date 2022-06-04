import 'package:digitaez/Models/service/leaveService.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Models/core/LeaveRequestModel.dart';
import 'package:digitaez/Screens/ProfileScreen/PendingRequestScreen/Components/RequestCard.dart';
import 'package:digitaez/Screens/ProfileScreen/Components/ScrollableButtons.dart';
import 'package:flutter/material.dart';

List<String> options = ["All", "Sick", "Casual", "Parental"];

class PendingRequestScreen extends StatefulWidget {
  const PendingRequestScreen({Key? key}) : super(key: key);

  @override
  _PendingRequestScreenState createState() => _PendingRequestScreenState();
}

class _PendingRequestScreenState extends State<PendingRequestScreen> {
  int _selectedIndex = 0;
  int _allIndex = 1;
  int _sickIndex = 1;
  int _casualIndex = 1;
  int _parentalIndex = 1;

  bool isloading1 = false;
  bool isloading2 = false;
  bool isloading3 = false;
  bool isloading4 = false;
  List<RequestModel> _allList = [];
  List<RequestModel> _sickList = [];
  List<RequestModel> _casualList = [];
  List<RequestModel> _parentalList = [];

  ScrollController _controller1 = ScrollController();
  ScrollController _controller2 = ScrollController();
  ScrollController _controller3 = ScrollController();
  ScrollController _controller4 = ScrollController();

  Future<List<RequestModel>>? _future1;
  Future<List<RequestModel>>? _future2;
  Future<List<RequestModel>>? _future3;
  Future<List<RequestModel>>? _future4;

  bool one1 = true;
  bool one2 = true;
  bool one3 = true;
  bool one4 = true;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  initState() {
    if (one1) {
      _future1 = getAll();
      one1 = false;
    }
    if (one2) {
      _future2 = getSick();
      one2 = false;
    }
    if (one3) {
      _future3 = getCasual();
      one3 = false;
    }
    if (one4) {
      _future4 = getParental();
      one4 = false;
    }

    super.initState();
    controllerListner1();
    controllerListner2();
    controllerListner3();
    controllerListner3();
  }

  void controllerListner1() {
    _controller1.addListener(() async {
      if (_controller1.position.pixels ==
          _controller1.position.maxScrollExtent) {
        setState(() {
          isloading1 = true;
        });
        await getAll();
        setState(() {
          isloading1 = false;
        });
      }
    });
  }

  void controllerListner2() {
    _controller2.addListener(() async {
      if (_controller2.position.pixels ==
          _controller2.position.maxScrollExtent) {
        setState(() {
          isloading2 = true;
        });
        await getSick();
        setState(() {
          isloading2 = false;
        });
      }
    });
  }

  void controllerListner3() {
    _controller3.addListener(() async {
      if (_controller3.position.pixels ==
          _controller3.position.maxScrollExtent) {
        setState(() {
          isloading3 = true;
        });
        await getCasual();
        setState(() {
          isloading3 = false;
        });
      }
    });
  }

  void controllerListner4() {
    _controller3.addListener(() async {
      if (_controller4.position.pixels ==
          _controller4.position.maxScrollExtent) {
        setState(() {
          isloading4 = true;
        });
        await getCasual();
        setState(() {
          isloading4 = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Future<List<RequestModel>> getAll() async {
    var payload = await LeaveService.getLeaves("All", _allIndex);
    _allList.addAll(payload);
    if (payload.length != 0) _allIndex++;
    return _allList;
  }

  Future<List<RequestModel>> getSick() async {
    var payload = await LeaveService.getLeaves("Sick", _sickIndex);
    _sickList.addAll(payload);
    if (payload.length != 0) _sickIndex++;
    return _sickList;
  }

  Future<List<RequestModel>> getCasual() async {
    var payload = await LeaveService.getLeaves("Casual", _casualIndex);
    _casualList.addAll(payload);
    if (payload.length != 0) _casualIndex++;
    return _casualList;
  }

  Future<List<RequestModel>> getParental() async {
    var payload = await LeaveService.getLeaves("Parental", _parentalIndex);
    _parentalList.addAll(payload);
    if (payload.length != 0) _parentalIndex++;
    return _parentalList;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: appBar(context, "Pending Request", () {
        Navigator.pop(context);
      }),

      body: Column(
        children: [
          Container(
            height: height * 0.09,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) =>
                    ScrollableButton(
                        index: index,
                        selectedIndex: _selectedIndex,
                        option: options[index],
                        function: _onSelected)),
          ),
          Expanded(
              child: _selectedIndex == 0
                  ? FutureBuilder(
                      future: _future1,
                      builder: (BuildContext ctx,
                          AsyncSnapshot<List<RequestModel>> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasData && _allList.length != 0) {
                          return ListView.builder(
                              controller: _controller1,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  RequestCard(
                                      request: _allList[index],
                                      index: index,
                                      last: _allList.length,
                                      isloading: isloading1));
                        } else
                          return Container(
                            height: height * 0.6,
                            child: Center(child: Text("No Requests to show")),
                          );
                      })
                  : _selectedIndex == 1
                      ? FutureBuilder(
                          future: _future2,
                          builder: (BuildContext ctx,
                              AsyncSnapshot<List<RequestModel>> snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasData && _sickList.length != 0) {
                              return ListView.builder(
                                  controller: _controller2,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          RequestCard(
                                              request: _sickList[index],
                                              index: index,
                                              last: _sickList.length,
                                              isloading: isloading2));
                            } else
                              return Container(
                                height: height * 0.6,
                                child: Center(
                                    child: Text("No Sick Requests to show")),
                              );
                          })
                      : _selectedIndex == 2
                          ? FutureBuilder(
                              future: _future3,
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<List<RequestModel>> snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasData &&
                                    _casualList.length != 0) {
                                  return ListView.builder(
                                      controller: _controller3,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              RequestCard(
                                                  request: _casualList[index],
                                                  index: index,
                                                  last: _casualList.length,
                                                  isloading: isloading3));
                                } else
                                  return Container(
                                    height: height * 0.6,
                                    child: Center(
                                        child:
                                            Text("No Casual Requests to show")),
                                  );
                              })
                          : FutureBuilder(
                              future: _future4,
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<List<RequestModel>> snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasData &&
                                    _parentalList.length != 0) {
                                  return ListView.builder(
                                      controller: _controller3,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              RequestCard(
                                                  request: _parentalList[index],
                                                  index: index,
                                                  last: _parentalList.length,
                                                  isloading: isloading4));
                                } else
                                  return Container(
                                    height: height * 0.6,
                                    child: Center(
                                        child: Text(
                                            "No Parental Requests to show")),
                                  );
                              }))
        ],
      ),
    );
  }
}
