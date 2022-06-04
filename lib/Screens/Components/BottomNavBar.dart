// import 'package:digitaez/Screens/DishScreen/DishScreen.dart';
// import 'package:digitaez/Screens/HomeScreen/HomeScreen.dart';
// import 'package:digitaez/Screens/ProfileScreen/ProfileScreen.dart';
// import 'package:double_back_to_close/double_back_to_close.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class BottomNavBar extends StatefulWidget {
//   int navPos;
//   BottomNavBar({Key? key, this.navPos = 0}) : super(key: key);

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return DoubleBack(
//       message: "Press back again to close",
//       child: Scaffold(
//         //backgroundColor: Colors.amber,
//         body: Stack(
//           children: [
//             IndexedStack(
//               index: widget.navPos,
//               children: [
//                 HomeScreen(),
//                 DishScreen(),
//                 ProfileScreen(),
//               ],
//             ),
//             Align(
//                 alignment: Alignment.bottomCenter,
//                 child: new Theme(
//                     data: Theme.of(context).copyWith(
//                       canvasColor: Color(0xFF2E3359),
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(30),
//                             topLeft: Radius.circular(30)),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.grey.shade400,
//                               spreadRadius: 0,
//                               blurRadius: 10),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30.0),
//                           topRight: Radius.circular(30.0),
//                         ),
//                         child: Stack(overflow: Overflow.visible, children: [
//                           new BottomNavigationBar(
//                             showSelectedLabels: false,
//                             showUnselectedLabels: false,
//                             type: BottomNavigationBarType.fixed,
//                             elevation: 40,
//                             //unselectedItemColor: Colors.green,
//                             // selectedItemColor: Colors.blue,
//                             backgroundColor: Colors.white,
//                             currentIndex: widget.navPos,
//                             onTap: (i) {
//                               setState(() {
//                                 widget.navPos = i;
//                               });
//                             },
//                             items: [
//                               new BottomNavigationBarItem(
//                                   icon: widget.navPos == 0
//                                       ? new SvgPicture.asset(
//                                           'assets/images/home3.svg',
//                                           fit: BoxFit.contain,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.06,
//                                           //  width: 180.0,
//                                         )
//                                       : new SvgPicture.asset(
//                                           'assets/images/home2.svg',
//                                           fit: BoxFit.contain,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.027,
//                                         ),
//                                   label: "Home"),
//                               new BottomNavigationBarItem(
//                                   icon: widget.navPos == 1
//                                       ? Container(
//                                           child: new SvgPicture.asset(
//                                             'assets/images/dush3.svg',
//                                             fit: BoxFit.contain,
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.06,
//                                           ),
//                                         )
//                                       : new SvgPicture.asset(
//                                           'assets/images/dish2.svg',
//                                           fit: BoxFit.contain,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.023,
//                                         ),
//                                   label: "Dish"),
//                               new BottomNavigationBarItem(
//                                   icon: widget.navPos == 2
//                                       ? new SvgPicture.asset(
//                                           'assets/images/profile2.svg',
//                                           fit: BoxFit.contain,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.06,
//                                         )
//                                       : new SvgPicture.asset(
//                                           'assets/images/profile1.svg',
//                                           fit: BoxFit.contain,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.028,
//                                         ),
//                                   label: "Profile"),
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: widget.navPos == 0
//                                     ? MediaQuery.of(context).size.width * 0.06
//                                     : widget.navPos == 1
//                                         ? MediaQuery.of(context).size.width *
//                                             0.385
//                                         : MediaQuery.of(context).size.width *
//                                             0.72),
//                             // left: widget.navPos == 0
//                             //     ? MediaQuery.of(context).size.width * 0.083
//                             //     : MediaQuery.of(context).size.width * 0.5),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.22,
//                               height:
//                                   MediaQuery.of(context).size.height * 0.003,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.topRight,
//                                     colors: [
//                                       Color(0xFF5CC5C1),
//                                       Color(0xFF1379B6)
//                                     ]),
//                               ),
//                             ),
//                           ),
//                         ]),
//                       ),
//                     )))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:digitaez/Screens/HomeScreen/HomeScreen.dart';
import 'package:digitaez/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatefulWidget {
  int navPos;
  BottomNavBar({Key? key, this.navPos = 0}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: "Press back again to close",
      child: Scaffold(
        //backgroundColor: Colors.amber,
        body: Stack(
          children: [
            IndexedStack(
              index: widget.navPos,
              children: [
                HomeScreen(),
                // DishScreen(),
                ProfileScreen(),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF2E3359),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 0,
                              blurRadius: 10),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: Stack(overflow: Overflow.visible, children: [
                          new BottomNavigationBar(
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            type: BottomNavigationBarType.fixed,
                            elevation: 40,
                            //unselectedItemColor: Colors.green,
                            // selectedItemColor: Colors.blue,
                            backgroundColor: Colors.white,
                            currentIndex: widget.navPos,
                            onTap: (i) {
                              setState(() {
                                widget.navPos = i;
                              });
                            },
                            items: [
                              new BottomNavigationBarItem(
                                  icon: widget.navPos == 0
                                      ? new SvgPicture.asset(
                                          'assets/images/home3.svg',
                                          fit: BoxFit.contain,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          //  width: 180.0,
                                        )
                                      : new SvgPicture.asset(
                                          'assets/images/home2.svg',
                                          fit: BoxFit.contain,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                        ),
                                  label: "Home"),
                              // new BottomNavigationBarItem(
                              //     icon: widget.navPos == 1
                              //         ? Container(
                              //             child: new SvgPicture.asset(
                              //               'assets/images/dush3.svg',
                              //               fit: BoxFit.contain,
                              //               height: MediaQuery.of(context)
                              //                       .size
                              //                       .height *
                              //                   0.06,
                              //             ),
                              //           )
                              //         : new SvgPicture.asset(
                              //             'assets/images/dish2.svg',
                              //             fit: BoxFit.contain,
                              //             height: MediaQuery.of(context)
                              //                     .size
                              //                     .height *
                              //                 0.023,
                              //           ),
                              //     label: "Dish"),
                              new BottomNavigationBarItem(
                                  icon: widget.navPos == 1
                                      ? new SvgPicture.asset(
                                          'assets/images/profile2.svg',
                                          fit: BoxFit.contain,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                        )
                                      : new SvgPicture.asset(
                                          'assets/images/profile1.svg',
                                          fit: BoxFit.contain,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                        ),
                                  label: "Profile"),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                // left: widget.navPos == 0
                                //     ? MediaQuery.of(context).size.width * 0.083
                                //     : widget.navPos == 1
                                //         ? MediaQuery.of(context).size.width *
                                //             0.415
                                //         : MediaQuery.of(context).size.width *
                                //             0.75),
                                left: widget.navPos == 0
                                    ? MediaQuery.of(context).size.width * 0.06
                                    : MediaQuery.of(context).size.width * 0.55),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              height:
                                  MediaQuery.of(context).size.height * 0.003,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xFF72BAA8),
                                      Color(0xFF79BE74)
                                    ]),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
