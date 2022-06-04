import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OfficeTimng {
  static Future<String> getOfficeTiming() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      final http.Response response = await http.get(
        Uri.parse(Constants.getOfficeTiming),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final responseData = json.decode(response.body);
      //   print("office timming");
      //  print(responseData);
      if (response.statusCode == 200) {
        if (responseData['data'] == null) {
          return "--";
        } else {
          return getTime(responseData['data']);
        }
      } else {
        Fluttertoast.showToast(
            msg: "error fetching office timming", backgroundColor: Colors.red);
        return "--";
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: "You are connected to no or weak internet",
          backgroundColor: Colors.red);
      throw Exception('Unable to fetch Earned coin data from the REST API');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      throw Exception('Request timeout');
    }
  }

  static String getTime(Map<String, dynamic> json) {
    if (json['startTime'] == "OFF") {
      return "OFF DAY";
    }
    return json['startTime'] + "-" + json['endTime'];
  }
}
