import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visit_saltus/screens/home_screens/category_screens/list_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool showspinner = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 0, left: 65, right: 65),
              child: Text("اهلا بك في السلط ",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35)),
            ),
            Expanded(
              flex: 1,
              child: ListView(
                reverse: false,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  _popularTrips("assets/images/category/res.jpg", "المطاعم", 5),
                  _popularTrips("assets/images/category/religion.jpg",
                      "المعالم الدينية", 6),
                  _popularTrips(
                      "assets/images/category/musuem.jpg", "المتاحف العامة", 3),
                  _popularTrips("assets/images/category/street.jpg",
                      "الترفيه والرحلات والجولات", 1),
                  _popularTrips("assets/images/category/hotels.jpg",
                      "الفنادق والمنامات", 2),
                  _popularTrips("assets/images/category/7.jpg", "المحميات", 4),
                  _popularTrips("assets/images/category/6.jpg",
                      "المواقع الاثرية والطبيعية", 7),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _popularTrips(String img, text, int categoryId) {
    return Container(
      width: 300,
      height: 150,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Stack(
        children: <Widget>[
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyListScreen(
                          categoryId: categoryId,
                          categoryName: (text.toString()))));
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 15, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      text.toString(),
                      // textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
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
