import 'dart:io';
import 'package:digitaez/Models/core/UserModel.dart';
import 'package:digitaez/Models/service/AuthService.dart';
import 'package:digitaez/Provider/UserNotifier.dart';
import 'package:digitaez/Screens/Components/Button.dart';
import 'package:digitaez/Screens/Components/textFeild.dart';
import 'package:digitaez/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final Function function;
  final imageVersion;
  const EditProfile(
      {Key? key, required this.function, required this.imageVersion})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void initState() {
    // Start listening to changes.
    final user = Provider.of<UserNotifier>(context, listen: false).getuser();
    _name.text = user.username != null ? user.username! : "";
    // _password.text = "*******";
    _designation.text =
        user.designation != null ? user.designation!.toString() : "";
    super.initState();
  }

  ScrollController _mycontroller1 = new ScrollController();
  ScrollController _mycontroller2 = new ScrollController();

  final _name = TextEditingController();
  final _password = TextEditingController();
  final _designation = TextEditingController();
  File? _image;

  Future getImagefromcamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  Future getImagefromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
        ),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getImagefromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImagefromcamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserNotifier>(context).getuser();
    var model = Provider.of<UserNotifier>(context);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.white,
              height: height,
              width: width,
              child: NotificationListener<ScrollNotification>(
                  child: Stack(children: [
                    SingleChildScrollView(
                      controller: _mycontroller1,
                      child: Column(
                        children: [
                          // ClipPath(
                          //   clipper: ClippingClass(),
                          //   child: Container(
                          //       height: 225,
                          //       width:width,
                          //       decoration: BoxDecoration(
                          //         gradient: LinearGradient(
                          //             begin: Alignment.centerLeft,
                          //             end: Alignment.centerRight,
                          //             colors: [
                          //               Color(0xFF5cc5c1),
                          //               Color(0xFF268db8)
                          //             ]),
                          //       )),
                          // ),
                          // Image.asset(
                          //   'assets/images/background1.png',
                          //   fit: BoxFit.contain,
                          //   width: width,
                          // ),
                          Container(
                              height: height * 2,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: height,
                          width: width,
                          child: SingleChildScrollView(
                              controller: _mycontroller2,
                              child: Row(
                                children: [
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: width > 450
                                              ? width * 0.04
                                              : width * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: (() {
                                                Navigator.pop(context);
                                              }),
                                              icon: Icon(Icons.arrow_back),
                                              iconSize: height * 0.03,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Edit Profile",
                                              style: TextStyle(
                                                  fontSize: height * 0.024,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            IconButton(
                                              onPressed: (() {}),
                                              icon: Icon(Icons.arrow_back),
                                              iconSize: height * 0.03,
                                              color: Colors.transparent,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: width > 450
                                              ? width * 0.25
                                              : height * 0.06 - (width * 0.01),
                                        ),
                                        Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Card(
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          height * 0.1),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                    height * 0.007,
                                                  ),
                                                  child: Card(
                                                      elevation: 5,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: height * 0.07,
                                                        backgroundImage: _image !=
                                                                null
                                                            ? FileImage(_image!)
                                                                as ImageProvider
                                                            : user.photo !=
                                                                    "no-photo.jpg"
                                                                ? NetworkImage(Constants
                                                                        .profileUploads +
                                                                    user.photo! +
                                                                    '#v=${widget.imageVersion}')
                                                                : null,
                                                        child: (user.photo ==
                                                                    "no-photo.jpg" &&
                                                                !(_image !=
                                                                    null))
                                                            ? SvgPicture.asset(
                                                                'assets/images/profile-circle.svg')
                                                            : null,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    height *
                                                                        0.072),
                                                      )),
                                                ),
                                              ),
                                              InkWell(
                                                child: SvgPicture.asset(
                                                  'assets/images/edit.svg',
                                                  fit: BoxFit.contain,
                                                  height: height * 0.06,
                                                ),
                                                onTap: (() {
                                                  _showPicker(context);
                                                }),
                                              )
                                            ]),
                                        SizedBox(height: height * 0.03),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03,
                                                vertical: height * 0.015),
                                            child: Text("Full Name",
                                                style: TextStyle(
                                                    fontSize: height * 0.017,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        textFeild(
                                          context,
                                          _name,
                                          "Name",
                                          font: height * 0.017,
                                          width: width * 0.96,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03,
                                                vertical: height * 0.015),
                                            child: Text("Change Password",
                                                style: TextStyle(
                                                    fontSize: height * 0.017,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        TextFeildPassword(
                                          controller: _password,
                                          hint: "*******",
                                          font: height * 0.017,
                                          width: width * 0.96,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.03,
                                                    vertical: height * 0.015),
                                                child: Text("Designation",
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.017,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Text(
                                                "Only Admin can Change",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: height * 0.015),
                                              )
                                            ]),
                                        textFeild(context, _designation,
                                            "Designation",
                                            font: height * 0.017,
                                            width: width * 0.96,
                                            en: false),
                                        SizedBox(height: height * 0.06),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Button(
                                              onPressed: () {
                                                _name.text = user.username!;
                                                Navigator.pop(context);
                                              },
                                              text1: "Discard",
                                              font: height * 0.018,
                                              width: width * 0.4,
                                              height: height * 0.055,
                                              colored: false,
                                            ),
                                            Button(
                                                onPressed: () async {
                                                  if (_name.text.length < 3 ||
                                                      _name.text.length > 12) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "name should be in between length 3 and 13",
                                                        textColor: Colors.white,
                                                        backgroundColor:
                                                            Colors.red);
                                                  } else if (_password
                                                          .text.isNotEmpty &&
                                                      _password.text.length <
                                                          6) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "minimum pass length should be 6",
                                                        textColor: Colors.white,
                                                        backgroundColor:
                                                            Colors.red);
                                                  } else {
                                                    var res = await AuthSevice
                                                        .updateDetails(
                                                      _name.text,
                                                      _password.text,
                                                      _image,
                                                    );
                                                    if (res["success"]) {
                                                      UserModel user =
                                                          UserModel.fromJson(
                                                              res["data"]);

                                                      Provider.of<UserNotifier>(
                                                              context,
                                                              listen: false)
                                                          .updateUserObject(
                                                              user);
                                                      Navigator.pop(context);
                                                      widget.function();
                                                      Fluttertoast.showToast(
                                                          msg: "Changes saved",
                                                          textColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.green);
                                                    }
                                                  }
                                                },
                                                text1: "Save Changes",
                                                font: height * 0.018,
                                                width: width * 0.4,
                                                height: height * 0.055),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.35),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                ],
                              )),
                        )),
                  ]),
                  onNotification: (ScrollNotification scrollInfo) {
                    // HEY!! LISTEN!!
                    // this will set controller1's offset the same as controller2's
                    _mycontroller1.jumpTo(_mycontroller2.offset);
                    return true;
                  }),
            ),
          ),
        ));
  }
}
