import 'package:flutter/material.dart';

import 'package:material_kit_flutter/constants/Theme.dart';

//widgets
import 'package:material_kit_flutter/widgets/navbar.dart';

import 'package:material_kit_flutter/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String user, imgUrl;
  _getuserpreferneces() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user = preferences.getString("Display-Name") ?? "";
      imgUrl = preferences.getString("User-Image-URL") ?? "";
      switchValueOne = preferences.getBool("Theme-Mode") ?? false;
      darkmode = switchValueOne;
    });
  }

  bool switchValueOne, darkmode;

  void initState() {
    setState(() {
      switchValueOne = false;
    });
    super.initState();
  }

  void setpreferneces() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("Theme-Mode", switchValueOne);
  }

  _getcolor() {
    return (switchValueOne)
        ? Color.fromARGB(255, 30, 45, 55)
        : MaterialColors.bgColorScreen;
  }

  _gettextcolor() {
    return (darkmode) ? Colors.white : Colors.black;
  }

  _getbgimage() {
    return (darkmode)
        ? AssetImage("assets/img/setting-icon-white.png")
        : AssetImage("assets/img/setting-icon-black.png");
  }

  @override
  Widget build(BuildContext context) {
    _getuserpreferneces();
    return Scaffold(
        appBar: Navbar(
          title: "Settings",
        ),
        drawer:
            MaterialDrawer(currentPage: "Settings", user: user, imgUrl: imgUrl),
        backgroundColor:
            (darkmode != null) ? _getcolor() : MaterialColors.bgColorScreen,
        body: Container(
            height: MediaQuery.of(context).size.height,
            /*decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/setting-icon.png"),
                fit: BoxFit.contain,
              ),
            ),*/
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Recommended Settings",
                            style: TextStyle(
                                color: (darkmode != null)
                                    ? _gettextcolor()
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("These are the most important settings",
                            style: TextStyle(
                                color: (darkmode != null)
                                    ? _gettextcolor()
                                    : Colors.black,
                                fontSize: 14)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: Icon(
                            Icons.nights_stay_outlined,
                            size: 25,
                            color: (darkmode != null)
                                ? _gettextcolor()
                                : Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                          child: Text("Dark Mode",
                              style: TextStyle(
                                fontSize: 25,
                                color: (darkmode != null)
                                    ? _gettextcolor()
                                    : Colors.black,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(160.0, 10.0, 0.0, 0.0),
                          child: Switch.adaptive(
                            value: switchValueOne,
                            onChanged: (bool newValue) => {
                              setState(() => switchValueOne = newValue),
                              setpreferneces()
                            },
                            activeColor: Color.fromARGB(255, 15, 185, 130),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Image(
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.width * .5,
                          image: (darkmode != null)
                              ? _getbgimage()
                              : AssetImage("assets/img/setting-icon-black.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
