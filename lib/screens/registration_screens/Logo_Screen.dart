import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_saltus/screens/home_screens/homepage_screen.dart';
import 'package:visit_saltus/screens/home_screens/main_introduction_screen.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkIfLoggedIn(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Image.asset(
                "assets/logo/logo.jpg",
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Visit Saltus',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff003556),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'v1.0.7',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.black,
                ),
              ),
            ),
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  checkIfLoggedIn(context) async {
    print('checkIfLoggedIn');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userString = pref.getString('userData');
    if (userString == null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainIntroductionScreen()),
            (route) => false);
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage2()),
            (route) => false);
      });
    }
  }
}
