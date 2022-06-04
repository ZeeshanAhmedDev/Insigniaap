import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:digitaez/Models/core/DishModel.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DishService {
  static Future<List<DishModel>> getDish(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      String endPoint = Constants.dish + '&page=' + index.toString();

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
      // print(response.body);
      final parsed = json.decode(response.body);
      // print(parsed);
      if (response.statusCode == 200) {
        var list = parsed['data']
            .map<DishModel>((json) => DishModel.fromMap(json))
            .toList();

        return list;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);
        throw Exception('Unable to fetch Dish data from the REST API');
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
