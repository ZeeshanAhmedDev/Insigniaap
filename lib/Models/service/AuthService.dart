import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'dart:convert';

class AuthSevice {
  static Future<Map<String, dynamic>> getToken(
      String email, String password) async {
    try {
      Map data = {"email": email, "password": password};
      // print(Constants.tokenURL);
      final http.Response response = await http
          .post(
        Uri.parse(Constants.tokenURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final Map<String, dynamic> responseData = json.decode(response.body);
      //print(3);
      if (response.statusCode == 200) {
        var token = responseData['token'];
        log("---------" + token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
      } else {
        Fluttertoast.showToast(
            msg: responseData['error'], backgroundColor: Colors.red);
        log('error-------' + responseData['error']);
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
      log(e.toString());
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      Map<String, dynamic> res = new Map();
      res['success'] = false;
      return res;
    }
  }

  static Future<Map<String, dynamic>> getMe() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      final http.Response response = await http.get(
        Uri.parse(Constants.getMeURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      final Map<String, dynamic> responseData = json.decode(response.body);

      //print(responseData);
      if (response.statusCode == 200) {
      } else {
        Fluttertoast.showToast(
            msg: "saved token " + responseData['error'],
            backgroundColor: Colors.red);
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
      Fluttertoast.showToast(msg: "Token Expires", backgroundColor: Colors.red);
      Map<String, dynamic> res = new Map();
      res['success'] = false;
      return res;
    }
  }

  static Future<bool> forgotPassword(String email) async {
    try {
      Map data = {"email": email};

      final http.Response response = await http
          .post(
        Uri.parse(Constants.ForgotPasswordURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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
            msg: responseData['data'], backgroundColor: Colors.green);
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

  static Future<Map<String, dynamic>> updateDetails(
      String name, String password, File? image) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      Map<String, String> headers = {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      };

      var request =
          http.MultipartRequest("PUT", Uri.parse(Constants.updateDetails));
      request.headers.addAll(headers);
      request.fields['username'] = name;
      if (password.length != 0) request.fields['password'] = password;
      if (image != null)
        request.files
            .add(await http.MultipartFile.fromPath('file', image.path));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request
          .send()
          .timeout(const Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      final res = await http.Response.fromStream(response);
      final responseData = json.decode(res.body);
      if (response.statusCode == 200) {
        //  print(responseData);
      } else {
        Fluttertoast.showToast(
            msg: responseData['error'], backgroundColor: Colors.red);
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
}
