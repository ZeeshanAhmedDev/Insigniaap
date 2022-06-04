import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:digitaez/Models/core/RedeemCoin.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RedeemCoinService {
  static Future<List<RedeemCoinModel>> getRedeemCoin(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      final http.Response response = await http.get(
        Uri.parse(Constants.Wallet + '?page=' + index.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final parsed = json.decode(response.body);
      // print(parsed);
      if (response.statusCode == 200) {
        var list = parsed['data']
            .map<RedeemCoinModel>((json) => RedeemCoinModel.fromMap(json))
            .toList();

        return list;
      } else {
        Fluttertoast.showToast(
            msg: parsed['error'], backgroundColor: Colors.red);
        throw Exception('Unable to fetch redeem coin data from the REST API');
      }
    } on SocketException {
      throw Exception('Unable to fetch product data from the REST API');
    } catch (e) {
      throw Exception('Request timeout');
    }
  }

  static cancelRedeem(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');

      final http.Response response = await http.delete(
        Uri.parse(Constants.Wallet + '/' + id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      final parsed = json.decode(response.body);
      // print(parsed);
      if (response.statusCode == 200) {
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

      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      return false;
    }
  }
}
