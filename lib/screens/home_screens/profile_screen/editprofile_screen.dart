import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_saltus/entities/userModel.dart';
import 'package:visit_saltus/services/services_provider.dart';

final storage = new FlutterSecureStorage();

class EditProfileScreen extends StatelessWidget {
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
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _localImage;
  final cloudinaryCredentials =
      Cloudinary('417563464468785', 'gnoEEy4AoeFk3NOa2UTK1SSxn9E', 'hkc946rsd');
  Color myHexColor = Color(0xff195e83);
  final picker = ImagePicker();
  UserModel user;
  ServicesProvider _servicesProvider = ServicesProvider();
  bool showspinner = false;

  String _uploadedFileURL = "";

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController tempFirstName = TextEditingController();
  TextEditingController tempLastName = TextEditingController();
  TextEditingController _tempEmail = TextEditingController();
  bool showPassword = false;

  void initState() {
    super.initState();
    populateUser();
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
              Icons.check,
              color: myHexColor,
            ),
            onPressed: () {
              setState(() {
                showspinner = true;
              });
              if (_localImage != null) {
                uploadFile();
              } else {
                _updateUser(user.image);
              }
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => ProfilePage()));
            },
          ),
        ],
      ),
      body: user == null
          ? Center(child: new CircularProgressIndicator())
          : ModalProgressHUD(
              inAsyncCall: showspinner,
              child: Container(
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
                                      image: _localImage == null
                                          ? NetworkImage(user.image)
                                          : FileImage(_localImage),
                                    ))),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: myHexColor,
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        _showChooseImageSourceDialog();
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      new Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                              // ignore: deprecated_member_use
                              autovalidate: true,
                              validator: (value) {
                                tempFirstName.text = value;
                                return null;
                              },
                              controller: _firstNameController,
                              textAlign: TextAlign.right,
                              autofocus: false,
                              decoration: new InputDecoration(
                                labelText: "اسم الاول",
                              ))),
                      new Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                              // ignore: deprecated_member_use
                              autovalidate: true,
                              validator: (value) {
                                tempLastName.text = value;
                                return null;
                              },
                              controller: _lastNameController,
                              textAlign: TextAlign.right,
                              autofocus: false,
                              decoration: new InputDecoration(
                                labelText: "اسم الاخير",
                              ))),
                      new Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(

                              // ignore: deprecated_member_use
                              autovalidate: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                _tempEmail.text = value;
                                return null;
                              },
                              controller: _emailController,
                              textAlign: TextAlign.right,
                              autofocus: false,
                              decoration: new InputDecoration(
                                labelText: "الايميل",
                              ))),
                    ],
                  ),
                ),
              ),
            ),
    );
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

  Future getImage(ImageSource imgSource) async {
    final pickedFile = await picker.getImage(source: imgSource);

    setState(() {
      if (pickedFile != null) {
        _localImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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

  populateUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userString = pref.getString('userData');
    Map json = jsonDecode(userString);
    user = UserModel.fromJson(json);
    _firstNameController.text = user.firstname;
    _lastNameController.text = user.lastname;
    _emailController.text = user.email;
    _emailController.text = user.email;
    setState(() {});
  }

  // Future uploadFile() async {
  //   if (_image != null) {
  //     Reference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child('chats/${Path.basename(_image.path)}}');
  //     UploadTask uploadTask = storageReference.putFile(_image);
  //     await uploadTask;
  //     storageReference.getDownloadURL().then((fileURL) {
  //       setState(() {
  //         _uploadedFileURL = fileURL;
  //         _updateUser(_uploadedFileURL.toString());
  //       });
  //     });
  //   } else {
  //     _updateUser(user.image);
  //   }
  // }

  uploadFile() async {
    final response = await cloudinaryCredentials.uploadFile(_localImage.path);
    print(response.secureUrl);
    _updateUser(response.secureUrl);
  }

  _updateUser(String imageURL) async {
    UserModel result = await _servicesProvider.editProfile(
        user.id,
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _phoneController.text,
        imageURL);
    setState(() {
      showspinner = false;
    });
    setState(() {
      if (result != null) {
        saveUserData(result);
      }
    });
  }

  saveUserData(UserModel userModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = jsonEncode(userModel);
    pref.setString('userData', user);
    Navigator.pop(context);
  }
}
