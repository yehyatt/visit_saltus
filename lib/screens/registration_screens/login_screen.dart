import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_saltus/entities/userModel.dart';
import 'package:visit_saltus/screens/home_screens/homepage_screen.dart';
import 'package:visit_saltus/screens/registration_screens/signup_screen.dart';
import 'package:visit_saltus/services/services_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final storage = new FlutterSecureStorage();
  final _auth = FirebaseAuth.instance;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isHidePassword = true;
  ServicesProvider _servicesProvider = ServicesProvider();
  String phoneValidation = "";
  String passwordValidation = "";
  bool showspinner = false;
  String _verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: ModalProgressHUD(
          inAsyncCall: showspinner,
          child: new SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'الرجاء ! تسجيل الدخول للاستمرار',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 18),
                            width: 120,
                            height: 120,
                            child: SvgPicture.asset("assets/images/logo.svg")),
                        SizedBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width * 0.88,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff003556),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone_android),
                                    // errorText: phoneValidation,
                                    hintText: '  رقم الهاتف',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    suffix: Container(
                                      width: 90,
                                      child: Row(
                                        children: [
                                          Text("962+ "),
                                          SvgPicture.asset(
                                            "assets/images/jordan.svg",
                                            width: 30,
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    )),
                                //onChanged: (input) => _email = input,
                              ),
                            ),
                            Text(phoneValidation,
                                style: TextStyle(color: Colors.red))
                          ],
                        )),
                        SizedBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width * 0.88,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff003556),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: isHidePassword,
                                decoration: InputDecoration(
                                  suffixIcon: new GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isHidePassword = !isHidePassword;
                                      });
                                    },
                                    child: (new Icon(isHidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                  ),
                                  prefixIcon: Icon(Icons.lock_outline),
                                  hintText: ' كلمة المرور ',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Text(passwordValidation,
                                style: TextStyle(color: Colors.red))
                          ],
                        )),
                        SizedBox(
                          height: 22,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'نسيت كلمة المرور ؟ ',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 50,
                          margin:
                              EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () {
                              if (_phoneController.text.isEmpty) {
                                setState(() {
                                  phoneValidation = "يرجى ادخال رقم الهاتف";
                                });
                              }
                              if (_passwordController.text.isEmpty) {
                                setState(() {
                                  passwordValidation = "يرجى ادخال كلمة السر ";
                                });
                              }

                              if (_passwordController.text.isNotEmpty &&
                                  _phoneController.text.isNotEmpty) {
                                _doLogin();
                                // getUserInfo().then((value) async {
                                //   setState(() {
                                //     showspinner = true;
                                //   });
                                //   if (value.data() != null) {
                                //     if (value.data()['phone_number'] ==
                                //             (_phoneController.text) &&
                                //         value.data()['password'] ==
                                //             _passwordController.text) {
                                //       print("success");
                                //       await storage.write(
                                //           key: 'phone',
                                //           value: _phoneController.text);
                                //       verifyPhoneNumber(
                                //           "+962" + _phoneController.text);
                                //
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   HomePage2()));
                                //       /*  Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => OtpScreen(
                                //                   phone: "+962" +
                                //                       _phoneController.text,
                                //                 )),
                                //       );*/
                                //     } else {
                                //       setState(() {
                                //         passwordValidation =
                                //             "invalid phone number or password";
                                //       });
                                //     }
                                //   } else {
                                //     print("faild");
                                //   }
                                // });
                              }
                            },
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUi()));

                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            color: Color(0xff003556),
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      //margin: new EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('لا يوجد لديك حساب ؟'),
                          FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                'انشاء حساب جديد',
                                style: TextStyle(
                                    color: Color(0xff195e83),
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _doLogin() async {
    setState(() {
      showspinner = true;
    });
    UserModel result = await _servicesProvider.login(
        _phoneController.text, _passwordController.text);
    setState(() {
      showspinner = false;
    });
    if (result == null) {
      setState(() {
        passwordValidation = "invalid phone number or password";
      });
    } else {
      saveUserData(result);
    }
  }

  saveUserData(UserModel userModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = jsonEncode(userModel);
    pref.setString('userData', user);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage2()));
  }

  void verifyPhoneNumber(String phone) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      print("Phone number automatically verified and user signed in: ");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {};
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("verification code: " + verificationId);
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 30),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {}
  }
}

/*String validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return 'Please enter mobile number';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}*/
void showErrorSnackBar(BuildContext context, String errorMessage) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      errorMessage,
      style: TextStyle(color: Colors.red),
    ),
  ));
}
