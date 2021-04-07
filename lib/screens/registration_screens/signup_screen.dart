import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_saltus/entities/userModel.dart';
import 'package:visit_saltus/screens/home_screens/homepage_screen.dart';
import 'package:visit_saltus/screens/registration_screens/otp.dart';
import 'package:visit_saltus/services/services_provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final cloudinary =
      Cloudinary('417563464468785', 'gnoEEy4AoeFk3NOa2UTK1SSxn9E', 'hkc946rsd');
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  ServicesProvider _servicesProvider = ServicesProvider();
  bool isHidePassword = true;
  int selectedRadio;
  String phoneValidation = "";
  String emailValidation = "";
  String passValidation = "";
  String confirmValidation = "";
  String birthday = "";

  bool showSpinner = false;
  bool phoneNotVerified = true;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  File _image;
  final picker = ImagePicker();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'انشاء حساب جديد ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
                InkWell(
                  onTap: () {
                    _showChooseImageSourceDialog();
                  },
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xff003556))),
                      child: _image == null
                          ? SvgPicture.asset("assets/images/user.svg")
                          : CircleAvatar(
                              backgroundImage: new FileImage(_image),
                              radius: 200.0,
                            )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff003556),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: TextFormField(
                    controller: _firstNameController,
                    autofocus: false,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: ' الاسم الاول  ',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff003556),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: ' الاسم الاخير ',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 0.88,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff003556),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.phone_android),
                            hintText: '  رقم الهاتف  ',
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
                      ),
                    ),
                    Text(phoneValidation, style: TextStyle(color: Colors.red))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 0.88,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff003556),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textAlign: TextAlign.right,
                        autofocus: false,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          prefixIcon: Icon(Icons.email),
                          hintText: ' البريد الالكتروني ',
                        ),
                      ),
                    ),
                    Text(
                      emailValidation,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * 0.88,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff003556),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
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
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: ' كلمة المرور ',
                      ),
                    ),
                  ),
                  Text(
                    passValidation,
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 0.88,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff003556),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: TextFormField(
                        controller: _confirmPasswordController,
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
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'تأكيد كلمة المرور'),
                      ),
                    ),
                    Text(
                      confirmValidation,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ' الجنس:',
                        style: new TextStyle(fontSize: 17.0),
                      ),
                      Radio(
                        value: 1,
                        groupValue: selectedRadio,
                        activeColor: Color(0xff003556),
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                        },
                      ),
                      Text(
                        'ذكر',
                        style: new TextStyle(fontSize: 17.0),
                      ),
                      Radio(
                        value: 2,
                        groupValue: selectedRadio,
                        activeColor: Color(0xff003556),
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                        },
                      ),
                      Text(
                        'انثى',
                        style: new TextStyle(fontSize: 17.0),
                      ),
                    ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: textFieldValidation()
                      ? RaisedButton(
                          onPressed: () async {
                            if (emailValidationMethod(_emailController.text)) {
                              setState(() {
                                emailValidation = "";
                              });
                            } else {
                              setState(() {
                                emailValidation =
                                    "الرجاء ادخال بريد الكتروني صحيح";
                              });
                            }
                            if (_phoneController.text.length == 9) {
                              setState(() {
                                phoneValidation = "";
                              });
                            } else {
                              setState(() {
                                phoneValidation = "الرجاء ادخال رقم هاتف صحيح";
                              });
                            }
                            if (_passwordController.text.length >= 8 &&
                                _passwordController.text.length < 15) {
                              setState(() {
                                passValidation = "";
                              });
                            } else {
                              setState(() {
                                passValidation =
                                    "الرجاء ادخال كلمة مرور صحيحة ،على أن تكون لا تقل عن 8 خانات و لا تزيد عن 15";
                              });
                            }

                            if (_confirmPasswordController.text ==
                                _passwordController.text) {
                              setState(() {
                                confirmValidation = "";
                              });
                            } else {
                              setState(() {
                                confirmValidation =
                                    "كلمة المرور غير مطابقة ، يرجى التأكد منها";
                              });
                            }

                            if (phoneValidation.isEmpty &&
                                emailValidation.isEmpty &&
                                passValidation.isEmpty &&
                                confirmValidation.isEmpty) {
                              _startRegisterProcess();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          color: Color(0xff003556),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                ' انشاء الحساب',
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
                        )
                      : RaisedButton(
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) => LoginPage()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          color: Colors.black26,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                ' انشاء الحساب',
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
        ),
      ),
    );
  }

  Future getImage(ImageSource imgSource) async {
    final pickedFile = await ImagePicker.pickImage(source: imgSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _showChooseImageSourceDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                getImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/images/camera.svg",
                height: 40,
                width: 40,
              ),
            ),
            InkWell(
              onTap: () {
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/images/gallery.svg",
                height: 40,
                width: 40,
              ),
            ),
          ],
        ));
      },
    );
  }

  _startRegisterProcess() {
    if (phoneNotVerified) {
      verifyPhone();
    } else {
      uploadProfileImage();
      setState(() {
        showSpinner = true;
      });
      if (_image == null) {
        createUserAPI("");
      } else {
        uploadProfileImage();
      }
    }
  }

  verifyPhone() async {
    final isSuccessfullyVerifiedResult = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              OtpScreen(phone: '+962' + _phoneController.text)),
    );
    if (isSuccessfullyVerifiedResult) {
      phoneNotVerified = false;
      _startRegisterProcess();
    }
  }

  uploadProfileImage() async {
    final response = await cloudinary.uploadFile(filePath: _image.path);
    createUserAPI(response.secureUrl);
  }

  createUserAPI(String imageUrl) async {
    setState(() {
      showSpinner = true;
    });
    UserModel result = await _servicesProvider.register(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneController.text,
        imageUrl);
    setState(() {
      showSpinner = false;
    });
    if (result == null) {
      setState(() {});
    } else {
      saveUserInSharedPreferences(result);
    }
  }

  saveUserInSharedPreferences(UserModel userModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = jsonEncode(userModel);
    pref.setString('userData', user);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage2()), (route) => false);
  }

  //MARK validations
  textFieldValidation() {
    if (_phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        selectedRadio <= 0) {
      return false;
    } else {
      return true;
    }
  }

  emailValidationMethod(String email) {
    if (RegExp(
            "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  passValidationMethod(String email) {
    if (RegExp(
            "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }
}
