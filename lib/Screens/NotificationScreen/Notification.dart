import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:digitaez/Models/core/NotificationModel.dart';
import 'package:digitaez/Screens/NotificationScreen/Components/NotificationVertical.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        "Notifications",
        () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Column(
            children: [
              Container(
                  child: Notifications.length == 0
                      ? Center(child: Text('No Notification to view'))
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          // scrollDirection: Axis.horizontal,
                          itemCount: Notifications.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025),
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      warningBar1(context,
                                          Notifications[index].type, index),
                                      announcementBar1(
                                          context,
                                          Notifications[index].title,
                                          Notifications[index].description,
                                          index,
                                          false)
                                    ],
                                  ),
                                  SizedBox(
                                      height: index == Notifications.length - 1
                                          ? MediaQuery.of(context).size.height *
                                              0.025
                                          : 0),
                                ],
                              ))),
            ],
          ),
        ),
      ),
    );
  }
}
