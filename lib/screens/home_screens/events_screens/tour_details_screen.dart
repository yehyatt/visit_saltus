import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visit_saltus/entities/pathsModel.dart';

class TourDetailsScreen extends StatelessWidget {
  PathsModel path;
  String image;
  TourDetailsScreen({this.path, this.image});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('ar', 'AE'),
        builder: (context, child) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  body: Details(
                path: path,
                image: image,
              )));
        });
  }
}

class Details extends StatefulWidget {
  PathsModel path;
  String image;

  Details({this.path, this.image});
  @override
  State<StatefulWidget> createState() {
    return DetailsState(path: path, image: image);
  }
}

class DetailsState extends State<Details> {
  PathsModel path;
  String image;
  List<String> pathList = [];

  DetailsState({this.path, this.image});

  @override
  Widget build(BuildContext context) {
    pathList = path.pathplaces.split(",");
    // var concatenate = StringBuffer();
    //
    // list.forEach((item) {
    //   concatenate.write(item + ",");
    // });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff195e83),
        title: Text(path.pathtitle),
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
          children: <Widget>[
            Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      path.pathtitle,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/time.svg",
                          width: 30,
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            path.pathtime,
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
                          "assets/images/options.svg",
                          width: 30,
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            path.pathtype,
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
                            return tour_text(pathList[index].toString());
                          },
                          itemCount: pathList.length,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/food.svg",
                          width: 30,
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            " وجبة غداء في مطعم الغربال ",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff195e83),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "سجل الاّن",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
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
