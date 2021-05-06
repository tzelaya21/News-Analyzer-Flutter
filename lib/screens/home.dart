import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';
import 'package:material_kit_flutter/widgets/navbar.dart';
import 'package:material_kit_flutter/widgets/drawer.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Home> {
  final mypassController = TextEditingController();
  String user, imgUrl;
  bool darkmode = false;
  bool _isprocessing = false;
  File imageFile;
  // ignore: non_constant_identifier_names
  int Count = 0;

  _getusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Count += 1;
      user = preferences.getString("Display-Name") ?? "";
      imgUrl = preferences.getString("User-Image-URL") ?? "";
      darkmode = preferences.getBool("Theme-Mode") ?? false;
    });
  }

  _getimage() {
    return (darkmode)
        ? AssetImage("assets/img/newspaper-white.png")
        : AssetImage("assets/img/newspaper-black.png");
  }

  _getcolor() {
    return (darkmode)
        ? Color.fromRGBO(30, 45, 55, 1)
        : MaterialColors.bgColorScreen;
  }

  void _openGallery(BuildContext context) async {
    // ignore: await_only_futures
    String pickedFile = await FilePicker.getFilePath(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    ).toString();
    setState(() {
      imageFile = File(pickedFile);
    });

    Navigator.pop(context);
  }

  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      // _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getshadowcolor() {
    return (darkmode)
        ? <BoxShadow>[
            BoxShadow(
                color: Colors.grey[850],
                offset: Offset(2, 2),
                blurRadius: 10,
                spreadRadius: 2)
          ]
        : <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ];
  }

  Widget _addDocument() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: InkWell(
            onTap: () => {
                  if (_isprocessing) {} else {_showChoiceDialog(context)}
                },
            child: Container(
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.width * 0.12,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: (darkmode != null)
                        ? _getshadowcolor()
                        : <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                    color: Color.fromARGB(255, 15, 185, 130)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Select New Article',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      buttonHeight: 30.0,
                    )
                  ],
                ))),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: InkWell(
            onTap: () => {
                  if (_isprocessing) {} else {_showChoiceDialog(context)}
                },
            child: Container(
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.width * 0.12,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: (darkmode != null)
                        ? _getshadowcolor()
                        : <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                    color: Color.fromARGB(255, 15, 185, 130)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Icon(
                        Icons.file_upload,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Upload',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      buttonHeight: 30.0,
                    )
                  ],
                ))),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    (Count == 0) ? _getusername() : print("Welcome.");
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: Navbar(
              title: "Home",
              transparent: false,
            ),
            backgroundColor:
                (darkmode != null) ? _getcolor() : MaterialColors.bgColorScreen,
            drawer:
                MaterialDrawer(currentPage: "Home", user: user, imgUrl: imgUrl),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (darkmode != null)
                        ? _getimage()
                        : AssetImage("assets/img/newspaper-black.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(children: <Widget>[
                  _searchbar(),
                  _search(),
                  _displayDocuments(),
                  _addDocument(),
                ]))));
  }

  _getDocs() {
    List<Widget> childs;
    for (int i = 0; i < 10; i++) {
      childs.add(Text(
        'Hi ${i}',
      ));
    }
    return childs;
  }

  Widget _displayDocuments() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.94,
      height: MediaQuery.of(context).size.height * 0.64,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Color.fromRGBO(15, 185, 130, 1),
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: _getDocs(),
    );
  }

  Widget _searchbar() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Find article.",
            hintStyle: TextStyle(
              fontFamily: "Bosch",
              fontSize: 15.0,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Color(0xfff3f3f4),
            filled: true,
            suffixIcon: Icon(Icons.search),
          ),
          obscureText: false,
          controller: mypassController,
        ));
  }

  _res() async {
    setState(() {
      _isprocessing = !_isprocessing;
    });
  }

  Widget _search() {
    return InkWell(
        onTap: () async {
          await _res();
          if (_isprocessing) {
          } else {
            //Navigator.pushReplacementNamed(context, "/home");
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: (darkmode != null)
                  ? _getshadowcolor()
                  : <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
              color: Color.fromARGB(255, 15, 185, 130)),
          child: (_isprocessing)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: CupertinoActivityIndicator(
                            radius: 10, animating: true),
                      ),
                      Text(
                        'Searching',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ])
              : Text(
                  'Search',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
        ));
  }
}
