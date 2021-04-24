import 'package:flutter/material.dart';
import 'package:flutter_app/Fade_navigation.dart';
import 'package:flutter_app/main.dart';

import 'secondPage.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GreenBackground(),
          GetStartedButton(),
          whiteBox(),
          nameText(),
          treeHeaderText(),
          treeTextInfo(),
          rotatedText()
        ],
      ),
    );
  }

  whiteBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 38.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: 130,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(0))),
        ),
      ),
    );
  }

  nameText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120, right: 120),
      child: Align(
          alignment: Alignment.center,
          child: Container(
              height: 250,
              width: 250,
              child: Image.asset("assets/images/qw.png"))),
    );
  }

  treeHeaderText() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(left: 90.0, right: 80, top: 170),
      child: Text(
        "Welcome to bonsia World",
        style: TextStyle(
            color: Colors.white54, fontSize: 29, fontWeight: FontWeight.w800),
      ),
    ));
  }

  treeTextInfo() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(left: 90.0, right: 80, top: 320),
      child: Text(
        "is simply dummy text of the printing and typesetting industry. Lorem Ipsum ",
        style: TextStyle(
            color: Colors.white54, fontSize: 14, fontWeight: FontWeight.normal),
      ),
    ));
  }

  rotatedText() {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(-90 / 360),
      child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 355.0, right: 35),
            child: Text(
              "HELLO WORLD",
              style: TextStyle(
                  color: Colors.white12,
                  fontSize: 28,
                  letterSpacing: 17,
                  fontWeight: FontWeight.w800),
            ),
          )),
    );
  }
}

class GreenBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 90),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0XFF308a2f),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, bottom: 120),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 160,
          child: TextButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ))),
            onPressed: () {
              final page = SecondPage();

              Navigator.of(context).push(CustomPageRoute(page));
            },
            child: Text(
              "Get Started  ➜",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
