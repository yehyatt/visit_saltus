import 'package:flutter/material.dart';
import 'package:visit_saltus/screens/registration_screens/login_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text(
              (" تسجيل الدخول  "),
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      )),
    );
  }
}
