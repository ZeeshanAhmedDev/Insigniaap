import 'dart:async';
import 'package:digitaez/Screens/ProfileScreen/ReedemCoinScreen/ReedemCoinScreen.dart';
import 'package:flutter/material.dart';

class RedeemBarSt extends StatefulWidget {
  const RedeemBarSt({Key? key}) : super(key: key);

  @override
  _RedeemBarStState createState() => _RedeemBarStState();
}

class _RedeemBarStState extends State<RedeemBarSt> {
  int _pos = 0;
  Timer? _timer;
  List<String> photos = ["zinger.png", "headphone.png"];

  @override
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        _pos = (_pos + 1) % photos.length;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.115,
      width: width * 0.96,
      color: Colors.transparent,
      child: InkWell(
        child: Card(
          elevation: 30,
          shadowColor: Colors.grey.shade100,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height * 0.023),
          ),
          child: Padding(
            padding: new EdgeInsets.only(left: width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "Redeem Coins",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Are you Hungry? or want to Buy?",
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.green, fontSize: height * 0.015),
                          ),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: new Image.asset(
                    'assets/images/' + photos[_pos],
                    gaplessPlayback: true,
                    fit: BoxFit.fitHeight,
                    height: height * 0.8,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RedeemCoinScreen()));
          //}
          //  );
        },
      ),
    );
  }
}
