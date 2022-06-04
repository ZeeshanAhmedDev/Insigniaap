import 'package:auto_size_text/auto_size_text.dart';
import 'package:digitaez/Models/service/DishService.dart';
import 'package:digitaez/Models/service/DishVoteService.dart';
import 'package:digitaez/Screens/DishScreen/DishScreen.dart';
import 'package:digitaez/Models/core/DishModel.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DishCardVertical extends StatefulWidget {
  final DishModel dish;
  final index;
  final length;
  final isloading;
  const DishCardVertical(
      {Key? key,
      required this.dish,
      required this.index,
      required this.length,
      required this.isloading})
      : super(key: key);

  @override
  _DishCardVerticalState createState() => _DishCardVerticalState();
}

class _DishCardVerticalState extends State<DishCardVertical> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: widget.index == 0
              ? new EdgeInsets.only(bottom: height * 0.008)
              : widget.index == widget.length - 1
                  ? new EdgeInsets.only(
                      top: height * 0.008,
                    )
                  : new EdgeInsets.symmetric(vertical: height * 0.008),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.03),
            ),
            //   shadowColor: Colors.transparent,
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(height * 0.03),
                ),
              ),
              height: height * 0.151,
              child: Padding(
                padding: new EdgeInsets.all(height * 0.01),
                child: Row(
                  children: [
                    Container(
                      height: height * 0.12,
                      width: height * 0.13,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.025)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF5cc5c1), Color(0xFF268db8)]),
                      ),
                      child: Card(
                          elevation: 4,
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(height * 0.02),
                          ),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: width * 0.15,
                              backgroundImage: NetworkImage(
                                Constants.dishUploads + widget.dish.image,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.dish.name,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height * 0.023,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            AutoSizeText(
                              widget.dish.description,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: height * 0.016,
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: !isLoading
                                    ? InkWell(
                                        onTap: (() async {
                                          if (voting == true) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            bool isvoted =
                                                await DishVoteService.VoteDish(
                                                    widget.dish.id);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            if (isvoted) {
                                              print("Vote ${widget.index} Tap");
                                              Fluttertoast.showToast(
                                                  textColor: Colors.white,
                                                  backgroundColor: Colors.green,
                                                  msg:
                                                      "Vote cast to ${widget.dish.name}");
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                textColor: Colors.white,
                                                backgroundColor: Colors.red,
                                                msg: "Voting is disabled");
                                          }
                                        }),
                                        child: SvgPicture.asset(
                                          'assets/images/vote.svg',
                                          height: height * 0.034,
                                        ),
                                      )
                                    : Container(
                                        height: height * 0.034,
                                        child: CircularProgressIndicator())),
                          ]),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        widget.index == widget.length - 1
            ? Container(
                height: widget.isloading ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 0,
              ),
        SizedBox(height: widget.index == widget.length - 1 ? height * 0.15 : 0),
      ],
    );
  }
}
