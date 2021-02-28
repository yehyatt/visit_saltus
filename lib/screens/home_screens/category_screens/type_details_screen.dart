import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TypeDetailsScreen extends StatelessWidget {
  String title;
  String img;
  String des;

  TypeDetailsScreen({this.title, this.img, this.des});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(body: Type(title: title, des: des, img: img));
  }
}
class Type extends StatefulWidget {
  String title;
  String img;
  String des;

  Type({this.title, this.img, this.des});

  @override
  State<StatefulWidget> createState() {
    return TypeState(title: title, des: des, img: img);
  }
}

class TypeState extends State<Type> {
  String title;
  String img;
  String des;

  TypeState({this.title, this.img, this.des});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        locale: Locale('ar', 'AE'),
        builder: (context, child) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xff195e83),
                  title: Text(title),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: SingleChildScrollView(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(15),
                        height: 380,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 35,
                              color: Color(0xff195e83),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/fill_star.png"),
                            Image.asset("assets/images/fill_star.png"),
                            Image.asset("assets/images/fill_star.png"),
                            Image.asset("assets/images/fill_star.png"),
                            Image.asset("assets/images/empty_star.png"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          des != null ? des : " ",
                          style:
                              TextStyle(fontSize: 25, color: Color(0xff195e83)),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
