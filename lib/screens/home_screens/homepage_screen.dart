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
    return Scaffold(
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
    );
  }
}
