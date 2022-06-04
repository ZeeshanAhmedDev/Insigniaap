import 'package:auto_size_text/auto_size_text.dart';
import 'package:digitaez/Models/core/RedeemCoin.dart';
import 'package:digitaez/Models/service/RedeemCoinService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class RedeemProductCard extends StatelessWidget {
  final RedeemCoinModel wallet;
  final index;
  final last;
  final isloading;
  const RedeemProductCard(
      {Key? key,
      required this.wallet,
      required this.isloading,
      required this.index,
      required this.last})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = Provider.of<UserNotifier>(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: width * 0.015,
              left: width * 0.015,
              top: height * 0.01,
              bottom: index == last - 1 ? height * 0.03 : height * 0.01),
          child: InkWell(
            child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(height * 0.02)),
                ),
                child: Container(
                  width: width * 0.96,
                  height: height * 0.13,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.01,
                        right: width * 0.03,
                        top: height * 0.005,
                        bottom: height * 0.005),
                    child: Row(
                      children: [
                        Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(height * 0.013),
                            ),
                            child: Padding(
                                padding: new EdgeInsets.symmetric(
                                    vertical: height * 0.003,
                                    horizontal: width * 0.01),
                                child: Image.network(
                                  Constants.productUploads + wallet.image,
                                  height: height * 0.11,
                                  width: width * 0.23,
                                ))),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.01,
                              top: height * 0.01,
                              bottom: height * 0.01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.62,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        wallet.name,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                        wallet.status == "Approved"
                                            ? "Delivered"
                                            : wallet.status,
                                        style: TextStyle(
                                            fontSize: height * 0.0168,
                                            color: wallet.status == "Pending"
                                                ? Colors.yellow.shade600
                                                : wallet.status == "Approved"
                                                    ? Color(0xFF3DF130)
                                                    : Colors.red))
                                  ],
                                ),
                              ),
                              Row(children: [
                                SvgPicture.asset(
                                  'assets/images/DGC.svg',
                                  height: height * 0.022,
                                ),
                                Text(
                                    " " +
                                        wallet.price.toString() +
                                        " SiniCoins",
                                    style: TextStyle(
                                      fontSize: height * 0.017,
                                    ))
                              ]),
                              Container(
                                width: width * 0.62,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        DateFormat('hh:mm aa     dd MMM yy')
                                            .format(wallet.createAt),
                                        style: TextStyle(
                                          fontSize: height * 0.016,
                                        )),
                                    SvgPicture.asset(
                                      'assets/images/slide.svg',
                                      fit: BoxFit.fitHeight,
                                      height: height * 0.033,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            onTap: () {
              wallet.status == "Pending"
                  ? showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Center(
                          child: Container(
                            width: width / 1.2,
                            height: height / 3.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height * 0.03))),
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.018,
                              horizontal: width * 0.03,
                            ),
                            child: Scaffold(
                                backgroundColor: Colors.white,
                                body: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.01),
                                            child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          height * 0.017),
                                                ),
                                                child: Image.network(
                                                  Constants.productUploads +
                                                      wallet.image,
                                                  height: height * 0.15,
                                                  width: width * 0.3,
                                                )),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: height * 0.01),
                                            child: Container(
                                              width: width * 0.44,
                                              height: height * 0.15,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      AutoSizeText(
                                                        wallet.name,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize:
                                                                height * 0.022,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Row(children: [
                                                        SvgPicture.asset(
                                                          'assets/images/DGC.svg',
                                                          height: height * 0.02,
                                                        ),
                                                        Text(
                                                            " " +
                                                                wallet.price
                                                                    .toString() +
                                                                " SiniCoins",
                                                            style: TextStyle(
                                                              fontSize: height *
                                                                  0.016,
                                                            )),
                                                      ]),
                                                      SizedBox(
                                                        height: height * 0.016,
                                                      ),
                                                      Text("Requested at",
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.0165)),
                                                      Text(
                                                          DateFormat(
                                                                  'hh:mm aa dd MMM yy')
                                                              .format(wallet
                                                                  .createAt),
                                                          style: TextStyle(
                                                            fontSize:
                                                                height * 0.0165,
                                                          )),
                                                      SizedBox(
                                                        height: height * 0.016,
                                                      ),
                                                      Text(
                                                          "Status: " +
                                                                      wallet
                                                                          .status ==
                                                                  "Approved"
                                                              ? "Delivered"
                                                              : wallet.status,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  height *
                                                                      0.0165,
                                                              color: wallet
                                                                          .status ==
                                                                      "Pending"
                                                                  ? Colors
                                                                      .yellow
                                                                      .shade600
                                                                  : wallet.status ==
                                                                          "Approved"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          width: width / 1.3,
                                          height: height * 0.06,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height * 0.15)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Cancel Order",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          bool isCancelled =
                                              await RedeemCoinService
                                                  .cancelRedeem(wallet.id);
                                          if (isCancelled) {
                                            model.incrementCoin(wallet.price);
                                            wallet.status = "Cancelled";

                                            Fluttertoast.showToast(
                                                msg:
                                                    "Your order of ${wallet.name} has been can cancelled",
                                                backgroundColor: Colors.green);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        );
                      })
                  : Fluttertoast.showToast(
                      msg: "Status is not pendiing",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      fontSize: height * 0.017);
            },
          ),
        ),
        index == last - 1
            ? Container(
                height: isloading ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 0,
              ),
        SizedBox(height: index == last - 1 ? 70 : 0),
      ],
    );
  }
}
