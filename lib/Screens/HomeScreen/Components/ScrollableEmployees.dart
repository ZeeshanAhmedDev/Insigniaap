import 'package:digitaez/Models/service/Employyee.dart';
import 'package:digitaez/Models/core/EmployeeModel.dart';
import 'package:digitaez/Screens/HomeScreen/Components/EmployeeList.dart';
import 'package:flutter/material.dart';

class ScrollableEmployees extends StatelessWidget {
  ScrollableEmployees(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: width * 0.02),
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: height * 0.025,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.003,
          ),
          Container(
            width: width,
            height: height * 0.125,
            child: FutureBuilder<List<EmployeeDayModel>>(
              future: EmployeeService.getEmployyeOfTheDay(),
              builder: (context, snapshot) {
                print(snapshot.hasData);
                print(snapshot.hasError);
                if (snapshot.hasError)
                  return Center(child: Text("No Employee to show"));
                return snapshot.hasData
                    ? EmployeeList(snapshot.data!)
                    : Center(
                        child: CircularProgressIndicator(
                        color: Color(0xFF7EC249),
                      ));
              },
            ),
            //
          ),
        ]);
  }
}
