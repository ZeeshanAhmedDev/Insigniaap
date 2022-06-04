import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:digitaez/Models/core/DishModel.dart';
import 'package:digitaez/Models/core/DishVoteModel.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DishVoteService {
  static Future<List<DishVoteModel>> getVoteDish(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      String endPoint = Constants.dishVote;

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
      //print("1");
      if (response.statusCode == 200) {
        print(parsed['data']);
        var list = parsed['data']
            .map<DishVoteModel>((json) => DishVoteModel.fromMap(json))
            .toList();
        print(list);
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
      throw Exception('Unable to fetch Dish data from the REST API');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      throw Exception('Request timeout');
    }
  }

  static Future<bool> VoteDish(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      String endPoint = Constants.dishVote + '/$id';

      final http.Response response = await http.post(
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
      //print("1");
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
      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Request TimeOut", backgroundColor: Colors.red);
      throw Exception('Request timeout');
    }
  }
}
