import 'package:flutter/material.dart';

// final usersRef = FirebaseFirestore.instance.collection('users');
// final firestoreInstance = FirebaseFirestore.instance;

class ProfileItemWidget extends StatefulWidget {
  final String comment;

  ProfileItemWidget({@required this.comment});

  @override
  _ProfileItemWidgetState createState() => _ProfileItemWidgetState();
}

class _ProfileItemWidgetState extends State<ProfileItemWidget> {
  var width = 0.0;
  var height = 0.0;
  var mail;
  @override
  void initState() {
    super.initState();
    getUserById();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: height * 0.015),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: width * 0.13,
                height: width * 0.13,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
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
                        image: NetworkImage(
                          "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                        ))),
              ),
              Text(
                mail,
                style: TextStyle(fontSize: width * 0.04),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.12),
            child: Text(
              widget.comment,
              style: TextStyle(fontSize: width * 0.04),
            ),
          ),
        ],
      ),
    );
  }

  //todo get user by id
  getUserById() async {
    // final id = await storage.read(key: "email");
    // usersRef.doc(id).get().then((DocumentSnapshot doc) {
    //   print(doc.data());
    //   print(doc.exists);
    //   setState(() {
    //     mail = doc.data()['email'];
    //   });
    // });
  }
}
