import 'package:digitaez/Models/service/AttendanceService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Screens/Components/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
//import 'package:geolocator/geolocator.dart';

class QrCode extends StatefulWidget {
  String attendanceMark;
  QrCode({Key? key, required this.attendanceMark}) : super(key: key);
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  bool _camState = true;
  bool isFirst = true;
  _qrCallback(String? code, UserNotifier model) async {
    String? _qrInfo = 'Scan a QR/Bar code';
    // final urlRegExp = new RegExp(
    //     r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    if (code!.endsWith(model.getuser().officeId.toString())) {
      if (isFirst) {
        setState(() {
          _camState = false;
          _qrInfo = code;
        });
      }

      if (!_camState && isFirst) {
        setState(() {
          isFirst = false;
        });

        if (widget.attendanceMark == "") {
          var res = await AttendaceService.markAttendance(_qrInfo!);
          if (res['success']) {
            model.incrementCoin(res['coinRewarded']);
            model.markAttendance("has attendance");
            Navigator.pop(context);
          } else {
            _scanCode();
            isFirst = true;
            Navigator.pop(context);
          }
        } else {
          var res = await AttendaceService.unmarkAttendance(_qrInfo!);
          if (res['success']) {
            model.unmarkAttendance();
            Navigator.pop(context);
          } else {
            _scanCode();
            isFirst = true;
            Navigator.pop(context);
          }
        }
      }
    }
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var model = Provider.of<UserNotifier>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context, "Scanning QR Code", () {
        Navigator.of(context).pop();
      }, colored: false),
      backgroundColor: Colors.grey.shade500,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
          ),
          !_camState
              ? SizedBox(
                  height: 0,
                  width: 0,
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: QRBarScannerCamera(
                    fit: BoxFit.cover,
                    onError: (context, error) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: error.toString(), backgroundColor: Colors.red);
                      return Text("");
                    },
                    qrCodeCallback: (code) {
                      _qrCallback(code, model);
                    },
                  ),
                ),
          Positioned(
            bottom: height * 0.15,
            left: width * 0.42,
            child: Container(
              margin: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Color(0xFF7BBF4F),
                strokeWidth: 5,
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.1,
            left: width * 0.2,
            child: _camState
                ? Button(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text1: "Back to Home Screen",
                    height: height * 0.055,
                    font: height * 0.018,
                    colored: false,
                    width: width * 0.6,
                  )
                : Text("Code Scanned... Marking Attendance",
                    style: TextStyle(
                        color: Colors.white, fontSize: height * 0.02)),
          )
        ],
      ),
    );
  }
}
