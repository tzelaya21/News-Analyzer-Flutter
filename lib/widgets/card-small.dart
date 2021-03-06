import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';

class CardSmall extends StatefulWidget {
  final String cta, title;
  CardSmall({this.title = "Name Holder", this.cta = ""});

  @override
  _CardSmallState createState() => _CardSmallState();
}

class _CardSmallState extends State<CardSmall> {
  Future defaultFunc() async {
    await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Profile picture not selected."),
            content: Text(
                "Please select a profile picture before procceding with registration."),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 0))
      ], borderRadius: BorderRadius.all(Radius.circular(10.0))),
      width: 100,
      height: 100,
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
          onTap: () => {defaultFunc()},
          child: Stack(overflow: Overflow.clip, children: [
            Card(
                elevation: 0.7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(flex: 0, child: Container()),
                    Flexible(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title,
                                  style: TextStyle(
                                      color: MaterialColors.caption,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Text(widget.cta,
                                    style: TextStyle(
                                        color: MaterialColors.muted,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            FractionalTranslation(
                translation: Offset(0, 0.45),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/img/pdficon.png'),
                        fit: BoxFit.scaleDown,
                        scale: 1,
                      )),
                    )))
          ])),
    ));
  }
}
