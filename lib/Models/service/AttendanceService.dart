import 'dart:async';
import 'dart:io';

import 'package:digitaez/Models/core/AttendanceModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'dart:convert';

class AttendaceService {
  static Future<Map<String, dynamic>> markAttendance(String details) async {
    try {
      Map data = {
        "hour": details.split(':')[0],
        "minute": details.split(':')[1]
      };
      // Map data = {"hour": 9, "minute": 5};
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      print("token:" + token!);

      final http.Response response = await http
          .post(
        Uri.parse(Constants.attendance),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "Your Attendenace has been Marked at \n " +
              details.split(':')[0].toString() +
              ":" +
              details.split(':')[1].toString() +
              " with " +
              responseData['coinRewarded'].toString() +
              " coins rewarded",
          backgroundColor: Colors.green,
        );
      } else {
        Fluttertoast.showToast(
            msg: responseData['error'],
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG);
      }
      return responseData;
    } on SocketException {
      Fluttertoast.showToast(
          msg: "You are connected to no or weak internet",
          backgroundColor: Colors.red);
      Map<String, dynamic> res = new Map();
      res['success'] = false;
      return res;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      Map<String, dynamic> res = new Map();
      res['success'] = false;
      return res;
    }
  }

  static Future<Map<String, dynamic>> unmarkAttendance(String details) async {
    try {
      Map data = {
        "hour": details.split(':')[0],
        "minute": details.split(':')[1]
      };
      // Map data = {"hour": 9, "minute": 5};
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      print("token:" + token!);

      final http.Response response = await http
          .put(
        Uri.parse(Constants.attendance),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Your Attendenace has been Unmarked at \n " +
              details.split(':')[0].toString() +
              ":" +
              details.split(':')[1].toString(),
          backgroundColor: Colors.green,
        );
      } else {
        Fluttertoast.showToast(
            msg: responseData['error'],
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG);
      }
      return responseData;
    } on SocketException {
      Fluttertoast.showToast(
          msg: "You are connected to no or weak internet",
          backgroundColor: Colors.red);
      Map<String, dynamic> res = new Map();
      res['success'] = false;
      return res;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      Map<String, dynamic> res = new Map();
      res['success'] = false;
      return res;
    }
  }

  static Future<List<AttendanceModel>> getAttendance(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      print(Constants.attendance + '?sort=-startTime&page=' + index.toString());
      final http.Response response = await http.get(
        Uri.parse(
            Constants.attendance + '?sort=-startTime&page=' + index.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final parsed = json.decode(response.body);
      print(parsed);

      if (response.statusCode == 200) {
        List<AttendanceModel> list = parsed['data']
            .map<AttendanceModel>((json) => AttendanceModel.fromMap(json))
            .toList();
        print(list.length);
        return list;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);
        throw Exception('Unable to fetch Earned attendance');
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: "You are connected to no or weak internet",
          backgroundColor: Colors.red);
      throw Exception('Unable to fetch Earned atteandance');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      throw Exception('Request Timeout');
    }
  }

  static Future<List<AttendanceModel>> getAttendanceMonth(DateTime date) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      String s =
          '&startTime[gte]=${date.year}-${date.month}-1&startTime[lte]=${date.year}-${date.month}-${DateTime(date.year, date.month + 1, 0).day}';
      print(Constants.attendance + '?sort=-startTime' + s);
      final http.Response response = await http.get(
        Uri.parse(Constants.attendance + '?sort=-startTime' + s),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final parsed = json.decode(response.body);

      if (response.statusCode == 200) {
        List<AttendanceModel> list = parsed['data']
            .map<AttendanceModel>((json) => AttendanceModel.fromMap(json))
            .toList();
        print(list.length);
        return list;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);
        throw Exception('Unable to fetch Earned atteandance');
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: "You are connected to no or weak internet",
          backgroundColor: Colors.red);
      throw Exception('Unable to fetch Earned atteandance');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      throw Exception('Request Timeout');
    }
  }
}
