import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visit_saltus/entities/locationsModel.dart';
import 'package:visit_saltus/models/restlist.dart';
import 'package:visit_saltus/screens/home_screens/category_screens/type_details_screen.dart';
import 'package:visit_saltus/services/services_provider.dart';
import 'package:visit_saltus/shared/alert.dart';

class MyListScreen extends StatefulWidget {
  int categoryId;
  String categoryName;

  MyListScreen({this.categoryId, this.categoryName});

  @override
  _MyListScreenState createState() =>
      _MyListScreenState(categoryId: categoryId, categoryName: categoryName);
}

class _MyListScreenState extends State<MyListScreen> {
  int categoryId;
  String categoryName;
  List<LocationsModel> locations;
  ServicesProvider _servicesProvider = ServicesProvider();
  _MyListScreenState({this.categoryId, this.categoryName});

  void initState() {
    super.initState();
    getLocations();
  }

  void getLocations() async {
    try {
      var _locations =
          await _servicesProvider.getLocationsByCategoryId(categoryId);
      setState(() {
        locations = _locations;
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

  Data request(Map<String, dynamic> body) {
    return Data.fromJson(body);
  }

  String _image;

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
              title: Text(categoryName),
            ),
            body: locations == null
                ? Center(
                    child: Text("...Loading"),
                  )
                : ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (_, index) {
                      return getContainer(
                          locations[index].locationtitle,
                          getImage(index),
                          locations[index].locationdescription);
                    },
                  ),
          ),
        );
      }, // OR Locale('ar', 'AE') OR Other RTL locales,
    );
  }

  getImage(int index) {
    if (locations[index].locationimage != null) {
      _image = locations[index].locationimage;
    } else {
      _image =
          "https://img2.arabpng.com/20180715/yag/kisspng-question-mark-computer-icons-exclamation-mark-desk-question-mark-emoji-5b4bb794264216.8330599815316888521567.jpg";
    }
    return _image;
  }

  getContainer(String title, String img, String des) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TypeDetailsScreen(
                      img: img,
                      title: title,
                      des: des,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 25, color: Color(0xff195e83)),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(right: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       Image.asset("assets/images/fill_star.png"),
                        //       Image.asset("assets/images/fill_star.png"),
                        //       Image.asset("assets/images/fill_star.png"),
                        //       Image.asset("assets/images/fill_star.png"),
                        //       Image.asset("assets/images/empty_star.png"),
                        //     ],
                        //   ),
                        // ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
