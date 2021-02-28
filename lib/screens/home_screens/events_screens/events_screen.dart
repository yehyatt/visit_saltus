import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visit_saltus/entities/pathsModel.dart';
import 'package:visit_saltus/screens/home_screens/events_screens/tour_details_screen.dart';
import 'package:visit_saltus/services/services_provider.dart';
import 'package:visit_saltus/shared/alert.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Event(),
    );
  }
}

class Event extends StatefulWidget {
  @override
  _EventList createState() => _EventList();
}

class _EventList extends State<Event> {
  List<PathsModel> fixedPathList;
  ServicesProvider _servicesProvider = ServicesProvider();
  void initState() {
    super.initState();
    getEvents();
  }

  void getEvents() async {
    try {
      var _fixedPathList = await _servicesProvider.getAllPaths();
      setState(() {
        fixedPathList = _fixedPathList;
      });
    } catch (error) {
      Alert.showSimpleAlert(
        context,
        title: 'Failed To get response',
        message: error.userReadableMessage,
        buttonTitle: 'Ok',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: fixedPathList == null
          ? Center(
              child: Text("...Loading"),
            )
          : Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                    child: Text("مسارات السلط السياحية",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 35)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                    child: Text("المسارات الثابتة",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                  Container(
                    height: 240,
                    child: ListView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        _buildContainer("assets/images/t_iiii.jpeg",
                            fixedPathList[0].pathtitle, "path1", 0),
                        _buildContainer("assets/images/t_iii.jpeg",
                            fixedPathList[1].pathtitle, "path2", 1),
                        _buildContainer("assets/images/t.jpeg",
                            fixedPathList[2].pathtitle, "path3", 2),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Text("مسارات متنوعة",
                        textAlign: TextAlign.end,
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
              ),
            ),
    );
  }

  Widget _buildContainer(String img, text, String path, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TourDetailsScreen(path: fixedPathList[index], image: img)),
          );
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
}
