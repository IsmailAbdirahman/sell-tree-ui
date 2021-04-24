import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color greyColor = Color(0XFFe6e6e6);
const Color greenColor = Color(0XFF308a2f);
const Color liteGreenColor = Color(0Xff30b844);
const Color discountColor = Color(0xffd3e014);

//---
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: greyColor,
      appBar: AppBarClass(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SearchWidget(),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CardWidget(),
              DiscountWidget(),
              CardImage(),
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "Varients",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RecommendedTree(),
              RecommendedTree(),
            ],
          )
        ],
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 82.0, left: 30),
      child: Center(
        child: Container(
            height: 190,
            child: Image(
              image: AssetImage("assets/images/er.png"),
            )),
      ),
    );
  }
}

class DiscountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.elliptical(38, 90)),
          color: discountColor,
        ),
        height: 80,
        width: 200,
        child: Center(
            child: Text(
          "%30 OFF",
          style: TextStyle(
              color: greenColor,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              fontSize: 17),
        )),
      ),
    );
  }
}

class AppBarClass extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: greyColor,
      title: Text(
        "Bonsia World",
        style: TextStyle(color: liteGreenColor),
      ),
      centerTitle: true,
      leading: Icon(
        Icons.library_music_outlined,
        color: liteGreenColor,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: liteGreenColor,
          ),
        )
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: BorderSide(color: Color(0XFFe6e6e6), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0XFFe6e6e6), width: 1.0),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Find Your Tree",
            suffixIcon: Icon(Icons.search)),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment(17, 20),
                tileMode: TileMode.repeated,
                colors: [
                  greyColor,
                  greenColor,
                ]),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.wb_sunny,
                color: Colors.yellowAccent,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 9),
                child: Icon(
                  Icons.lightbulb,
                  color: Colors.white70,
                  size: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 78.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chinese Elm",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                    Text(
                      "Plant's 6 years",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38.0, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      "\$350",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                          fontSize: 20),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendedTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RecommendedCardWidget(),
        Padding(
          padding: const EdgeInsets.only(left: 78.0),
          child: Container(
            height: 100,
            width: 100,
            child: Image(
              image: AssetImage("assets/images/er.png"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 73.0, left: 10),
          child: Icon(
            Icons.wb_sunny,
            color: Colors.yellow[800],
          ),
        ),
        LockWidget(),
        NameAndPriceTree(),
      ],
    );
  }
}

class NameAndPriceTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0, left: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ficus roya",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text(
              "\$190",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          )
        ],
      ),
    );
  }
}

class LockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 141, left: 140),
      child: Container(
        decoration: BoxDecoration(
            color: discountColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(14),
                topLeft: Radius.circular(14))),
        height: 35,
        width: 35,
        child: Icon(
          Icons.lock,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

class RecommendedCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Container(
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        height: 120,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
