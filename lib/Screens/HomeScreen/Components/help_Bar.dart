import 'package:flutter/material.dart';
import '../../ComplainScreen/LoadComplaintScreen/load_complaint_screen.dart';
import 'consts.dart';

class NeedHelp extends StatefulWidget {
  const NeedHelp({Key? key}) : super(key: key);

  @override
  _NeedHelpState createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                            "Need our Help?",
                            style: TextStyle(
                                color: HomePageConstant.kGreenColorForText,
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "if you need any help you can click here",
                            maxLines: 1,
                            style: TextStyle(
                                color: HomePageConstant.kGreenColorForText,
                                fontSize: height * 0.015),
                          ),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(86),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF18640F),
                          Color(0xFF13B217),
                        ],
                      ),
                    ),
                    child: Text(
                      'Get Help',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoadComplaintsScreen()));
        },
      ),
    );
  }
}
