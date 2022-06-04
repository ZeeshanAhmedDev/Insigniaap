import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digitaez/Models/core/EmployeeModel.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static Future<List<EmployeeDayModel>> getEmployyeOfTheDay() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      final http.Response response = await http.get(
        Uri.parse(Constants.getEmployeeOfTheDay),
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
        var list = parsed['data']
            .map<EmployeeDayModel>((json) => EmployeeDayModel.fromMap(json))
            .toList();
        return list;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);
        throw Exception(
            'Unable to fetch Employye of the day from the REST API');
      }
    } on SocketException {
      throw Exception('Unable to fetch Earned coin data from the REST API');
    } catch (e) {
      throw Exception('Request timeout');
    }
  }

  static Future<List<EmployeeMonthModel>> getEmployyeOfTheMonth() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      final http.Response response = await http.get(
        Uri.parse(Constants.getEmployeeOfTheMonth),
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
        var list = parsed['data']
            .map<EmployeeMonthModel>((json) => EmployeeMonthModel.fromMap(json))
            .toList();
        return list;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);
        throw Exception(
            'Unable to fetch Employye of the Month from the REST API');
      }
    } on SocketException {
      throw Exception('Unable to fetch Earned coin data from the REST API');
    } catch (e) {
      throw Exception('Request timeout');
    }
  }
}
