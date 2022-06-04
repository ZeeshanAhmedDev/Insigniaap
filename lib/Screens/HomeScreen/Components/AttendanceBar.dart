import 'package:digitaez/Screens/HomeScreen/Components/qrCode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:qrscan/qrscan.dart' as scanner;

Widget attendanceBar(BuildContext context, String attendanceMark) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  Future _scan() async {
    String? barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      print(barcode);
    }
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   print("checking location services...");
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Fluttertoast.showToast(msg: 'Location services are disabled.');
  //     return Future.error('Location services are disabled.');
  //   }
  //   print("checking permissions...");
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       Fluttertoast.showToast(msg: 'Location permissions are denied');
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     Fluttertoast.showToast(
  //         msg:
  //             'Location permissions are permanently denied, we cannot request permissions.');
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   Fluttertoast.showToast(msg: "Location Fetching..");
  //   return await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best)
  //       .timeout(Duration(seconds: 5), onTimeout: () {
  //     Fluttertoast.showToast(
  //         msg: 'getPosition() timeout. Trying Android Location Manager');
  //     return Geolocator.getCurrentPosition(
  //         forceAndroidLocationManager: true,
  //         desiredAccuracy: LocationAccuracy.low);
  //   });
  // }

  return Container(
    height: height * 0.1,
    width: width * 0.96,
    decoration: attendanceMark == ""
        ? BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height * 0.023)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF13b217), Color(0xFF19640f)]),
          )
        : BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height * 0.023)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.yellow.shade800, Colors.yellowAccent.shade700]),
          ),
    child: InkWell(
      child: Card(
        elevation: 20,
        shadowColor: Colors.transparent,
        color: Colors.transparent,
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
                          attendanceMark == ""
                              ? "Mark your Attendance"
                              : "UnMark your Attendance",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.017,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          attendanceMark == ""
                              ? "Scan QR code"
                              : "Scan QR code",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.015),
                        ),
                      )
                    ]),
              ),
              SvgPicture.asset(
                attendanceMark == ""
                    ? 'assets/images/mark.svg'
                    : 'assets/images/unmark.svg',
                fit: BoxFit.fitHeight,
                height: height * 0.1,
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        // _determinePosition().then((pos) {
        //   Fluttertoast.showToast(
        //       msg: pos.latitude.toString() + "  " + pos.longitude.toString())
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QrCode(attendanceMark: attendanceMark)));
        //}
        //  );
      },
    ),
  );
}
