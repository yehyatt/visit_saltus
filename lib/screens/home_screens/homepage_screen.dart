import 'package:flutter/material.dart';
import 'package:visit_saltus/models/bottom_navigation.dart';
import 'package:visit_saltus/screens/home_screens/profile_screen/profile_screen.dart';

import 'category_screens/category_screen.dart';
import 'events_screens/events_screen.dart';
import 'map_screen.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  Color maincolor = Color(0xff195e83);

  int currentindex = 0;
  List<BottomNavigationBarData> mybnt = [
    BottomNavigationBarData(
        page: MyMapScreen(), title: "الخريطة ", iconData: Icons.map),
    BottomNavigationBarData(
        page: CategoryScreen(),
        title: "الاقسام",
        iconData: Icons.account_balance),
    BottomNavigationBarData(
        page: EventsScreen(), title: "الرحلات", iconData: Icons.event),
    BottomNavigationBarData(
        page: ProfileScreen(),
        title: "الصفحة الشخصية ",
        iconData: Icons.account_circle),
  ];
  List<Widget> ScreensList = [
    MyMapScreen(),
    CategoryScreen(),
    EventsScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: ScreensList[currentindex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentindex = value;
            });
          },
          items: mybnt
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData),
                  title: Text(e.title),
                ),
              )
              .toList(),
          selectedItemColor: maincolor,
          unselectedItemColor: maincolor,
          currentIndex: currentindex,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    print('back called');
    if (currentindex == 0) {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the App'),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Text("YES"),
                ),
              ],
            ),
          ) ??
          false;
    } else {
      currentindex = 0;
      setState(() {});
      return Future.value(false);
    }
  }
}
