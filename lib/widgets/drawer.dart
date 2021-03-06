import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_kit_flutter/widgets/drawer-tile.dart';

class MaterialDrawer extends StatefulWidget {
  final String currentPage, user, imgUrl;

  MaterialDrawer({this.currentPage, this.user, this.imgUrl});
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MaterialDrawer> {
  bool darkmode;
  final FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences preferences;
  void setpreferences() async {
    preferences = await SharedPreferences.getInstance();
    preferences.remove("Display-Name");
    preferences.remove("User-Image-URL");
    preferences.remove("Email");
    preferences.remove("User-UID");
  }

  _getuserpreferneces() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      darkmode = preferences.getBool("Theme-Mode") ?? false;
    });
  }

  _getcolor() {
    return (darkmode) ? Colors.black : Colors.white;
  }

  _getcolor1() {
    return (darkmode)
        ? Color.fromARGB(255, 30, 45, 55)
        : MaterialColors.bgColorScreen;
  }

  _getcolor2() {
    return (darkmode)
        ? MaterialColors.bgColorScreen
        : Color.fromARGB(255, 30, 45, 55);
  }

  @override
  Widget build(BuildContext context) {
    _getuserpreferneces();
    return Drawer(
        child: Container(
            color: (darkmode != null) ? _getcolor1() : Colors.white,
            child: Column(
              children: [
                DrawerHeader(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 15, 185, 130)),
                    child: Container(
                        width: 300.0,
                        color: Color.fromARGB(255, 15, 185, 130),
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 30, 45, 55),
                              radius: 50,
                              backgroundImage: NetworkImage(widget.imgUrl),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 4.0, top: 8.0),
                              child: Text(widget.user,
                                  style: TextStyle(
                                      color: (darkmode != null)
                                          ? _getcolor()
                                          : Colors.white,
                                      fontSize: 18)),
                            ),
                          ],
                        ))),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Column(
                      children: [
                        DrawerTile(
                          icon: Icons.home,
                          onTap: () {
                            if (widget.currentPage != "Home")
                              Navigator.pushReplacementNamed(context, '/home');
                          },
                          iconColor:
                              (darkmode != null) ? _getcolor2() : Colors.black,
                          title: "Home",
                          isSelected:
                              widget.currentPage == "Home" ? true : false,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 485.0, 0.0, 0.0),
                          child: DrawerTile(
                            icon: Icons.settings,
                            onTap: () {
                              if (widget.currentPage != "Settings")
                                Navigator.pushReplacementNamed(
                                    context, '/settings');
                            },
                            iconColor: (darkmode != null)
                                ? _getcolor2()
                                : Colors.black,
                            title: "Settings",
                            isSelected:
                                widget.currentPage == "Settings" ? true : false,
                          ),
                        ),
                        DrawerTile(
                          icon: Icons.exit_to_app,
                          onTap: () async {
                            if (widget.currentPage != "Login") {
                              await auth.signOut();
                              setpreferences();
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          iconColor:
                              (darkmode != null) ? _getcolor2() : Colors.black,
                          title: "Logout",
                          isSelected:
                              widget.currentPage == "Login" ? true : false,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
