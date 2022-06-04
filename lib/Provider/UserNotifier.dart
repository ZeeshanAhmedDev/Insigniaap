import 'package:digitaez/Models/core/UserModel.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  UserModel _user = new UserModel();
  // UserModel _user = UserModel(
  //     username: "Ali Muhamamd",
  //     password: "123456",
  //     coin: 2500,
  //     designation: "Co-Founder | CEO");
  UserModel getuser() {
    return _user;
  }

  void updateUserObject(UserModel user) {
    // _user.username = user.username;
    // _user.coins = user.coins;
    // _user.designation = user.designation;
    // _user.photo = user.photo;
    // _user.email = user.email;
    // _user.joiningDate = user.joiningDate;
    // _user.hoursWorked = user.hoursWorked;
    // _user.leaves = user.leaves;
    _user = user;
    notifyListeners();
  }

  void incrementCoin(int coin) {
    _user.coins = _user.coins! + coin;
    notifyListeners();
  }

  void decrementCoin(int coin) {
    _user.coins = _user.coins! - coin;
    notifyListeners();
  }

  void decrementLeave(int leave) {
    _user.leaves = _user.leaves! - leave;
    notifyListeners();
  }

  void markAttendance(String att) {
    _user.attendanceMark = att;
    notifyListeners();
  }

  void unmarkAttendance() {
    _user.attendanceMark = "";
    notifyListeners();
  }

  void updateName(String name) {
    _user.username = name;
    notifyListeners();
  }

  void updateLeave(Map<String, dynamic> json) {
    _user.leaves = json["leaves"];

    notifyListeners();
  }

  void updateUser(
      {String? username,
      String? designation,
      String? image,
      double? hoursWorked,
      String? email,
      int? leaves,
      String? joiningDate,
      String? role,
      String? id,
      String? officeId,
      String? attendanceMark,
      int? coin}) {
    // _user.username = username != null ? username : _user.username;
    // _user.coins = coin != null ? coin : _user.coins;
    // _user.designation = designation != null ? designation : _user.designation;
    // _user.photo = image != null ? image : _user.photo;
    // _user.email = email != null ? email : _user.email;
    // _user.joiningDate = JoiningDate != null ? JoiningDate : _user.joiningDate;
    // _user.hoursWorked = hoursWorked != null ? hoursWorked : _user.hoursWorked;
    // _user.leaves = leaves != null ? leaves : _user.leaves;

    _user.username = username;
    _user.coins = coin;
    _user.designation = designation;
    _user.photo = image;
    _user.email = email;
    _user.joiningDate = joiningDate;
    _user.hoursWorked = hoursWorked;
    _user.leaves = leaves;
    _user.role = role;
    _user.id = id;
    _user.officeId = officeId;
    _user.attendanceMark = attendanceMark;
    notifyListeners();
  }

  void clearUser() {
    _user.username = null;
    _user.email = null;
    _user.coins = null;
    _user.id = null;
    _user.photo = null;
    _user.hoursWorked = null;
    _user.leaves = null;
    _user.role = null;
    _user.officeId = null;
    _user.attendanceMark = null;
    _user.joiningDate = null;
    _user.designation = null;
    notifyListeners();
  }
}
