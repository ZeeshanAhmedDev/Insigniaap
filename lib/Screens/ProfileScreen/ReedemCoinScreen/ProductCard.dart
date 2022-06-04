import 'package:auto_size_text/auto_size_text.dart';
import 'package:digitaez/Models/service/ProductService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Models/core/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final index;
  final last;
  final isloading;
  const ProductCard(
      {Key? key,
      required this.product,
      required this.isloading,
      required this.index,
      required this.last})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final _user = Provider.of<UserNotifier>(context).getuser();
    var model = Provider.of<UserNotifier>(context);

    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.01, vertical: height * 0.01),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Card(
              color: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height * 0.03),
                    topRight: Radius.circular(height * 0.03),
                    bottomLeft: Radius.circular(height * 0.06),
                    bottomRight: Radius.circular(height * 0.06)),
              ),
              child: Container(
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Image.network(
                      Constants.productUploads + product.image,
                      fit: BoxFit.contain,
                      height: height * 0.12,
                      width: width * 0.5,
                    ),
                  ],
                ),
              )),
          Container(
            height: height * 0.1,
            width: width * 0.46,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF72BAA4), Color(0xFF7CC050)]),
                borderRadius: BorderRadius.all(
                  Radius.circular(height * 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.5),
                    blurRadius: 2,
                  ),
                ]
                // border: Border.all(color: Color(0xFF2d95ba))
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.28,
                            child: FittedBox(
                              alignment: Alignment.topLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                product.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: height * 0.022,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Container(
                          width: width * 0.3,
                          child: FittedBox(
                            alignment: Alignment.topLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              product.price.toString() + " SiniCoins",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      onTap: () {
        showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black54,
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
              return Center(
                child: Stack(children: [
                  Container(
                    width: width / 1.2,
                    height: height / 2.2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.03))),
                    padding: EdgeInsets.all(height * 0.023),
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              Constants.productUploads + product.image,
                              fit: BoxFit.contain,
                              height: height * 0.14,
                              width: width * 0.5,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (2 * (width / 1.2) / 3.25),
                                  child: AutoSizeText(
                                    product.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.024,
                                    ),
                                  ),
                                ),
                                AutoSizeText(
                                  product.price.toString() + " SNC",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.02,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            AutoSizeText(product.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: height * 0.017,
                                )),
                          ]),
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.04,
                    left: (width / 2.4) - (width * 0.2),
                    child: Button(
                        onPressed: () async {
                          if (_user.coins! > product.price) {
                            Navigator.pop(context);
                            bool isRedeem =
                                await ProductService.redeemProduct(product.id);
                            if (isRedeem) {
                              model.decrementCoin(product.price);
                              Fluttertoast.showToast(
                                  msg: '${product.name} has been Ordered',
                                  textColor: Colors.white,
                                  backgroundColor: Colors.green);
                            }
                          } else {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Not enough coins",
                                textColor: Colors.white,
                                backgroundColor: Colors.red);
                          }
                        },
                        text1: "Redeem Now",
                        font: height * 0.018,
                        width: width * 0.4,
                        height: height * 0.055),
                  ),
                ]),
              );
            });
      },
    );
  }
}
