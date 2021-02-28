import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OtpScreen extends StatefulWidget {
  String phone;
  OtpScreen({this.phone});
  @override
  _otpPageState createState() => _otpPageState(phone: phone);
}

class _otpPageState extends State<OtpScreen> {
  String phone;
  bool verificationResult = false;
  _otpPageState({this.phone});
  String phoneValidation = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;
  final TextEditingController _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    verifyPhoneNumber(phone);
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: new SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Icon(Icons.crop_square,size: 50,color: Colors.grey,),
                      // SizedBox(
                      //   height: 155.0,
                      //   child: Image.asset(
                      //     "assets/8.png",
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                      //
                      // SizedBox(
                      //   height: 60,
                      // ),
                      Text(
                        'التحقق من رقم الهاتف',
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
                          child: SvgPicture.asset("assets/images/otp.svg")),

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
                              controller: _smsController,
                              decoration: InputDecoration(
                                // errorText: phoneValidation,
                                hintText: 'رمز التحقق',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              //onChanged: (input) => _email = input,
                            ),
                          ),
                          Text(phoneValidation,
                              style: TextStyle(color: Colors.red))
                        ],
                      )),

                      Container(
                        height: 50,
                        margin:
                            EdgeInsets.only(bottom: 10, left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            signInWithPhoneNumber();
                          },
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
                                'التالي',
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
              ],
            ),
          ),
        ));
  }

  void verifyPhoneNumber(String phone) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      print("Phone number automatically verified and user signed in: ");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      _otpValidationDialog(
          'Phone number verification failed ${authException.code}');
    };
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
    } catch (e) {
      _otpValidationDialog("Failed to Verify Phone Number: ${e}");
    }
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      Navigator.pop(context, true);
      print("Successfully signed in UID: ${user.uid}");
    } catch (e) {
      _otpValidationDialog("Invalid Verification Code ");
    }
  }

  _otpValidationDialog(String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.only(bottom: 20),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.red,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
