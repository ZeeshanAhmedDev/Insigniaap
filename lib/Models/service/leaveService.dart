import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:digitaez/Models/core/LeaveRequestModel.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LeaveService {
  static Future<List<RequestModel>> getLeaves(String type, int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      String endPoint;
      if (type == "All") {
        endPoint = Constants.leave + '?page=' + index.toString();
      } else {
        endPoint =
            Constants.leave + '?type=' + type + '&page=' + index.toString();
      }
      //print(endPoint);

      final http.Response response = await http.get(
        Uri.parse(endPoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final parsed = json.decode(response.body);
      // print(parsed);
      if (response.statusCode == 200) {
        var list = parsed['data']
            .map<RequestModel>((json) => RequestModel.fromMap(json))
            .toList();

        return list;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);

        throw Exception('Unable to fetch product data from the REST API');
      }
    } on SocketException {
      if (type == "All") {
        Fluttertoast.showToast(
            msg: "You are connected to no or weak internet",
            backgroundColor: Colors.red);
      }
      throw Exception('Unable to fetch Earned coin data from the REST API');
    } catch (e) {
      if (type == "All") {
        Fluttertoast.showToast(
            msg: "Request TimeOut", backgroundColor: Colors.red);
      }
      throw Exception('Request timeout');
    }
  }

  static Future<bool> registerLeave(String type, String reason, String doc,
      int count, DateTime start, DateTime end) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      Map<String, String> headers = {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      };

      var request = http.MultipartRequest("POST", Uri.parse(Constants.leave));
      request.headers.addAll(headers);
      request.fields['type'] = type;
      request.fields['reason'] = reason;
      request.fields['days'] = count.toString();
      request.fields['startDate'] =
          DateFormat('yyyy-MMM-dd').format(start).toString();
      request.fields['endDate'] =
          DateFormat('yyyy-MMM-dd').format(end).toString();
      if (doc != "")
        request.files.add(await http.MultipartFile.fromPath('file', doc));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request
          .send()
          .timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final res = await http.Response.fromStream(response);
      final responseData = json.decode(res.body);
      if (response.statusCode == 201) {
        //  print(responseData);
      } else {
        Fluttertoast.showToast(
            msg: responseData['error'], backgroundColor: Colors.red);
      }
      return responseData['success'];
    } on SocketException {
      Fluttertoast.showToast(
          msg: "You are connected to no or weak internet",
          backgroundColor: Colors.red);
      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      return false;
    }
  }
}
