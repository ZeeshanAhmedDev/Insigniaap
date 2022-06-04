import 'dart:convert';

class EmployeeDayModel {
  String name;
  int coin;

  EmployeeDayModel({required this.name, required this.coin});

  factory EmployeeDayModel.fromMap(Map<String, dynamic> j) {
    var map = json.encode(j['employee']);
    var e = json.decode(map);
    return EmployeeDayModel(
      name: e['username'],
      coin: j['totalcoins'],
    );
  }
}

class EmployeeMonthModel {
  String name;
  int totalcoin;
  double hoursWorked;
  int coins;
  int leaves;
  String designation;

  EmployeeMonthModel(
      {required this.name,
      required this.totalcoin,
      required this.hoursWorked,
      required this.designation,
      required this.leaves,
      required this.coins});

  factory EmployeeMonthModel.fromMap(Map<String, dynamic> j) {
    var map = json.encode(j['employee']);
    var e = json.decode(map);

    return EmployeeMonthModel(
      name: e['username'],
      totalcoin: j['totalcoins'],
      leaves: e['leaves'],
      coins: e['coins'],
      designation: e['designation'],
      hoursWorked: double.parse(e['hoursWorked'].toString()),
    );
  }
}
