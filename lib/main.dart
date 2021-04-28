import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

// screens
import 'package:material_kit_flutter/screens/home.dart';
import 'package:material_kit_flutter/screens/settings.dart';
import 'package:material_kit_flutter/screens/login.dart';

String user = "", imgUrl = "";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  user = preferences.getString("Display-Name") ?? "";
  runApp(MaterialKitPROFlutter(
    user: user,
  ));
}

class MaterialKitPROFlutter extends StatelessWidget {
  final String user;
  MaterialKitPROFlutter({this.user});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "AQI-Bosch",
        debugShowCheckedModeBanner: false,
        initialRoute: (user != "") ? "/home" : "/login",
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => new Login(),
          "/home": (BuildContext context) => new Home(),
          "/settings": (BuildContext context) => new Settings(),
        });
  }
}
