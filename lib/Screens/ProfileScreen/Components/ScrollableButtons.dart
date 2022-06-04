import 'package:digitaez/Screens/ProfileScreen/AttendanceScreen/AttendanceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ScrollableButton extends StatefulWidget {
  int index;
  int selectedIndex;
  String type;
  String option;
  final Function function;
  ScrollableButton(
      {Key? key,
      required this.index,
      this.type = '',
      required this.selectedIndex,
      required this.option,
      required this.function})
      : super(key: key);

  @override
  _ScrollableButtonState createState() => _ScrollableButtonState();
}

class _ScrollableButtonState extends State<ScrollableButton> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var selectedDate = DateTime.now();
    return Container(
        child: Padding(
            padding: widget.index == 0
                ? EdgeInsets.only(
                    left: width * 0.03,
                    top: height * 0.005,
                    bottom: height * 0.01)
                : widget.index == options.length
                    ? EdgeInsets.only(
                        right: width * 0.03,
                        top: height * 0.005,
                        bottom: height * 0.01)
                    : EdgeInsets.only(
                        left: width * 0.03,
                        right: width * 0.03,
                        top: height * 0.005,
                        bottom: height * 0.01),
            child: new Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF79C06C),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme: ColorScheme.light(primary: const Color(0xFF79C06C))
                    .copyWith(secondary: const Color(0xFF79C06C)),
              ),
              child: new Builder(
                builder: (context) => InkWell(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(height * 0.08),
                      ),
                      //   shadowColor: Colors.transparent,
                      elevation: 5,
                      child: Container(
                        decoration: widget.selectedIndex == widget.index
                            ? BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFF72BAA5),
                                      Color(0xFF7CC050)
                                    ]),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(height * 0.08),
                                ),
                                // border: Border.all(color: Color(0xFF2d95ba))
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(height * 0.08),
                                ),
                                // border: Border.all(color: Color(0xFF8cccca), width: 2)
                              ),
                        // width: MediaQuery.of(context).size.width * 0.34,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.option,
                              style: TextStyle(
                                  color: widget.selectedIndex == widget.index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: height * 0.019,
                                  fontWeight: FontWeight.w600),
                            ),
                            widget.index == 1 && widget.type == "Attendance"
                                ? Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SvgPicture.asset(
                                        'assets/images/down.svg',
                                        fit: BoxFit.contain,
                                        height: height * 0.01),
                                  )
                                : SizedBox(width: 0)
                          ],
                        ),
                      ),
                    ),
                    onTap: () async => {
                          widget.index == 1 && widget.type == "Attendance"
                              ? await showMonthPicker(
                                  context: context,
                                  firstDate: DateTime(2021, 7),
                                  lastDate:
                                      DateTime(DateTime.now().year + 1, 9),
                                  initialDate: DateTime(DateTime.now().year,
                                      DateTime.now().month),
                                  locale: Locale("en"),
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      selectedDate = date;
                                    });
                                  }
                                })
                              : null,
                          widget.type == "Attendance"
                              ? widget.function(widget.index, selectedDate)
                              : widget.function(widget.index)
                        }),
              ),
            )));
  }
}

// Widget ScrollableButtons(BuildContext context, int index, int _selectedIndex,
//     String option, function()) {
//   return Container(
//     child: Padding(
//       padding: index == 0
//           ? const EdgeInsets.only(left: 10, top: 8, bottom: 8)
//           : index == options.length - 1
//               ? const EdgeInsets.only(right: 10, left: 20, top: 8, bottom: 8)
//               : const EdgeInsets.only(left: 20, top: 8, bottom: 8),
//       child: InkWell(
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(17),
//           ),
//           //   shadowColor: Colors.transparent,
//           elevation: 7,
//           child: Container(
//             decoration: _selectedIndex == index
//                 ? BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         colors: [Color(0xFF5cc5c1), Color(0xFF268db8)]),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(17),
//                     ),
//                     // border: Border.all(color: Color(0xFF2d95ba))
//                   )
//                 : BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                     // border: Border.all(color: Color(0xFF8cccca), width: 2)
//                   ),
//             width: MediaQuery.of(context).size.width * 0.34,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   option,
//                   style: TextStyle(
//                       color:
//                           _selectedIndex == index ? Colors.white : Colors.black,
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 index == 1
//                     ? Image.asset('assets/images/down.png')
//                     : SizedBox(width: 0)
//               ],
//             ),
//           ),
//         ),
//         onTap: () => function(),
//       ),
//     ),
//   );
// }
