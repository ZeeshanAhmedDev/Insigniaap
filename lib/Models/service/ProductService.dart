import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:digitaez/Models/core/ProductModel.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<ProductModel>> getProduct(String type, int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      String endPoint;
      if (type == "All") {
        endPoint = Constants.product + '&page=' + index.toString();
      } else {
        endPoint =
            Constants.product + '&type=' + type + '&page=' + index.toString();
      }
      // print(endPoint);

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
      //print(parsed);
      if (response.statusCode == 200) {
        var list = parsed['data']
            .map<ProductModel>((json) => ProductModel.fromMap(json))
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
      throw Exception('Unable to fetch product data from the REST API');
    } catch (e) {
      if (type == "All") {
        Fluttertoast.showToast(
            msg: "Request TimeOut", backgroundColor: Colors.red);
      }
      throw Exception('Request timeout');
    }
  }

  static redeemProduct(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      Map data = {"productId": id};

      final http.Response response = await http
          .post(
        Uri.parse(Constants.Wallet),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      )
          .timeout(const Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final parsed = json.decode(response.body);
      // print(parsed);
      //print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);
        return false;
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: "You are connected to no or weak internet",
          backgroundColor: Colors.red);

      throw Exception('Unable to fetch product data from the REST API');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      throw Exception('Request timeout');
    }
  }
}
