import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as Path;
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

  _getcolor() {
    return (darkmode) ? Colors.black87 : MaterialColors.bgColorScreen;
  }

  void _openGallery(BuildContext context) async {
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
    return InkWell(
        onTap: () => {
              if (_isprocessing) {} else {_showChoiceDialog(context)}
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Text(
                  'Select Profile Picture',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            )));
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
                    image: AssetImage("assets/img/newspaper.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(children: <Widget>[
                  _searchbar(),
                  _search(),
                  Text("Hello"),
                  _addDocument(),
                  FlatButton(
                    child: Text(
                      'Generate PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => {},
                    color: Colors.blue,
                  )
                ]))));
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

  Widget _search() {
    return InkWell(
        onTap: () async {
          if (_isprocessing) {
          } else {
            Navigator.pushReplacementNamed(context, "/home");
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
