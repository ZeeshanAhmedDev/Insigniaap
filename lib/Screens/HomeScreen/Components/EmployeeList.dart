import 'package:digitaez/Models/core/EmployeeModel.dart';
import 'package:digitaez/Screens/HomeScreen/Components/EmployeeCard.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatelessWidget {
  final List<EmployeeDayModel> employees;
  EmployeeList(this.employees);

  @override
  Widget build(BuildContext context) {
    return employees.length == 0
        ? Center(child: Text("No Employee to show"))
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: employees.length,
            itemBuilder: (BuildContext context, int index) =>
                EmployeeCard(employee: employees[index], index: index));
  }
}
