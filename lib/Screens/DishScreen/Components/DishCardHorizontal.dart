import 'package:digitaez/Models/core/DishVoteModel.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';

class DishCardHorizontal extends StatefulWidget {
  final DishVoteModel dish;
  final index;
  const DishCardHorizontal({Key? key, required this.dish, required this.index})
      : super(key: key);

  @override
  _DishCardHorizontalState createState() => _DishCardHorizontalState();
}

class _DishCardHorizontalState extends State<DishCardHorizontal> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: widget.index == 0
              ? new EdgeInsets.symmetric(vertical: height * 0.008)
              : new EdgeInsets.only(
                  left: width * 0.01,
                  top: height * 0.008,
                  bottom: height * 0.008),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.02),
            ),
            //   shadowColor: Colors.transparent,
            elevation: 5,
            child: Container(
              decoration: widget.index == 0
                  ? BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF5cc5c1), Color(0xFF2A91B9)]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(height * 0.02),
                      ),
                      // border: Border.all(color: Color(0xFF2d95ba))
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(height * 0.02),
                      ),
                      // border: Border.all(color: Color(0xFF8cccca), width: 2)
                    ),
              width: width * 0.44,
              child: Row(
                children: [
                  Padding(
                    padding: new EdgeInsets.only(left: width * 0.003),
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(height * 0.013),
                        ),
                        child: Padding(
                          padding: new EdgeInsets.symmetric(
                              vertical: height * 0.003,
                              horizontal: width * 0.01),
                          child: Container(
                            child: CircleAvatar(
                              radius: height * 0.036,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                Constants.dishUploads + widget.dish.image,
                              ),
                              // child: Image.asset(
                              //   widget.dish.image,
                              //   fit: BoxFit.contain,
                              //   width: width * 0.12,
                              //   height: height * 0.06,
                              // ),
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          new EdgeInsets.symmetric(horizontal: width * 0.005),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.dish.name,
                                maxLines: 1,
                                style: TextStyle(
                                    color: widget.index == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: height * 0.016,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: new EdgeInsets.only(top: height * 0.007),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.dish.vote.toString() + " Votes",
                                  style: TextStyle(
                                      fontSize: height * 0.017,
                                      fontWeight: FontWeight.w600,
                                      color: widget.index == 0
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
