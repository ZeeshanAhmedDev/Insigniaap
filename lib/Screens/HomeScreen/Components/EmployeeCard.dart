import 'package:digitaez/Models/core/EmployeeModel.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatefulWidget {
  final EmployeeDayModel employee;
  final index;
  const EmployeeCard({Key? key, required this.employee, required this.index})
      : super(key: key);

  @override
  _EmployeeCardState createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: widget.index == 0
              ? const EdgeInsets.only(top: 8, bottom: 8)
              : const EdgeInsets.only(left: 10, top: 8, bottom: 8),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.02),
            ),
            //   shadowColor: Colors.transparent,
            elevation: 3,
            child: Container(
              decoration: widget.index == 0
                  ? BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF72BAA8), Color(0xFF7EC249)]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(height * 0.02),
                      ),
                      // border: Border.all(color: Color(0xFF2d95ba))
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(height * 0.02),
                      ),
                      border: Border.all(color: Color(0xFF8cccca), width: 2)),
              width: width * 0.4,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.employee.name,
                              maxLines: 1,
                              style: TextStyle(
                                  color: widget.index == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: height * 0.021,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.employee.coin.toString() + " Digicoins",
                                style: TextStyle(
                                    fontSize: height * 0.016,
                                    color: widget.index == 0
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
