import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_saltus/entities/userModel.dart';
import 'package:visit_saltus/screens/home_screens/profile_screen/editprofile_screen.dart';
import 'package:visit_saltus/screens/registration_screens/login_screen.dart';

// final usersRef = FirebaseFirestore.instance.collection('users');
final storage = new FlutterSecureStorage();

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.1,
              fontSizeDelta: 2.0,
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  Color myHexColor = Color(0xff195e83);
  UserModel user;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    populateUser();
  }

  populateUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userString = pref.getString('userData');
    Map json = jsonDecode(userString);
    user = UserModel.fromJson(json);
    firstName.text = user.firstname;
    lastName.text = user.lastname;
    _email.text = user.email;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: myHexColor,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditProfilePage()));
            },
          )
        ],
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: user.image == null
                                        ? AssetImage('assets/images/userp.png')
                                        : NetworkImage(user.image))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    new Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                            readOnly: true,
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            controller: firstName,
                            textAlign: TextAlign.right,
                            decoration: new InputDecoration(
                              labelText: "الاسم الاول",
                            ))),
                    new Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                            readOnly: true,
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            controller: lastName,
                            textAlign: TextAlign.right,
                            decoration: new InputDecoration(
                              labelText: "الاسم الاخير",
                            ))),
                    new Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            readOnly: true,
                            controller: _email,
                            textAlign: TextAlign.right,
                            decoration: new InputDecoration(
                              labelText: "الايميل",
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Center(
                                child: FlatButton(
                                    color: Colors.transparent,
                                    textColor: Colors.red,
                                    child: Text(
                                      'تسجيل الخروج',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          child: AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            title: new Text('تأكيد'),
                                            content: new Text(
                                                'هل أنت متأكد من تسجيل الخروج؟'),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text('تسجيل خروج'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  logout();
                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text('الغاء'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ));
                                    })))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  logout() async {
    print('logout');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
