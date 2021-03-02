import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visit_saltus/models/fixed_path.dart';

import 'package:expansion_tile_card/expansion_tile_card.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('ar', 'AE'),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Event(),
          );
        });
  }
}

class Event extends StatefulWidget {
  @override
  _EventList createState() => _EventList();
}

class _EventList extends State<Event> {
  List<FixedPath> fixedPath = List();
  List<String> path1 = [
    "متحف السلط التاريخي ",
    "الجامع الكبير",
    "الجامع الصغير ",
    "المجمع الانجليزي",
    "كنيسة الخضر ",
    "كنيسة الروم الارثوذكس",
    "كنيسة اللاتين"
  ];
  List<String> path2 = [
    "الجامع الكبير",
    "الجامع الصغير ",
    "سوق الاسكافية ",
    "قطايف أبو عفيف ",
    "سوق الخضروات الطازجة ",
    "كنيسة اللاتين"
  ];  List<String> path3 = [
    "مدرسة السلط الثانوية",
    "مدرسة سعيد البحرة ",
    "المدرسة السيفية"
  ];

  // final usersRef = FirebaseFirestore.instance.collection('fixedTouristPath');
  //
  // getEvents(String path) async {
  //   await usersRef.doc(path).get().then((DocumentSnapshot doc) {
  //     setState(() {
  //       print(doc.data());
  //
  //       fixedPath.add(FixedPath.fromJson(doc.data()));
  //     });
  //   });
  // }

  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardc = new GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Event == null
          ? Center(
        child: Text("...Loading"),
      )
          : Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                  EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                  child: Text("مسارات السلط السياحية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 35)),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                  child: Text("المسارات الثابتة",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpansionTileCard(
                  key: cardA,
                  title: Text('مسار الوئام'),
                  children: <Widget>[
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Container(
                        margin: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage("assets/images/athar.jpg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/options.svg",
                                  width: 30,
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    "وئام ديني معماري ثقافي",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/tour.svg",
                                  width: 30,
                                  height: 30,
                                ),
                                Text(
                                  "  المسار:",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return tour_text(
                                        path1[index]);
                                  },
                                  itemCount: path1.length,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ExpansionTileCard(
                  key: cardB,
                  title: Text('مسار الحياة اليومية '),
                  children: <Widget>[
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Container(
                        margin: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage("assets/images/jador.jpg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/options.svg",
                                  width: 30,
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    "وسط المدينة",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/tour.svg",
                                  width: 30,
                                  height: 30,
                                ),
                                Text(
                                  "  المسار:",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return tour_text(
                                        path2[index]);
                                  },
                                  itemCount: path2.length,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ExpansionTileCard(
                  key: cardc,
                  title: Text('المسار التعليمي '),
                  children: <Widget>[
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Container(
                        margin: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/althanaweh.jpg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/options.svg",
                                  width: 30,
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    "تعليمي",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/tour.svg",
                                  width: 30,
                                  height: 30,
                                ),
                                Text(
                                  "  المسار:",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return tour_text(
                                        path3[index]);
                                  },
                                  itemCount: path3.length,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Text("مسارات متنوعة",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                ),

                SizedBox(
                  height: 70,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "لا يوجد مسارات متاحة حاليا",
                    style: TextStyle(color: Colors.black26, fontSize: 20),
                  ),
                )
                // Expanded(
                //   flex: 1,
                //   child: ListView(
                //     scrollDirection: Axis.vertical,
                //     children: <Widget>[
                //       _popularTrips("assets/images/t_iiii.jpeg", "اسم المسار"),
                //       _popularTrips("assets/images/t_iii.jpeg", "اسم المسار"),
                //       _popularTrips("assets/images/t.jpeg", "اسم المسار"),
                //     ],
                //   ),
                // ),
              ],
            )),
      ),
    );
  }

  Widget _buildContainer(String img, text, String path, int index) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) =>
          //           TourDetailsScreen(path: newList[index], image: img)),
          // );
        },
        child: Container(
          width: 200,
          height: 300,
          margin: EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.only(top: 8, right: 5),
                        width: 90,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xff195e83),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            text.toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _popularTrips(String img, text) {
    return Container(
      width: 300,
      height: 150,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    text.toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text tour_text(String concatenate) {
    return Text(
      concatenate.toString(),
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
