import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visit_saltus/Widgets/profile_item_widget.dart';

class RatingScreen extends StatefulWidget {
  bool isLiked;
  List<String> comments;

  RatingScreen({this.isLiked, this.comments});

  @override
  RatingScreenState createState() => RatingScreenState();
}

class RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    double rating = 3.5;
    int starCount = 5;
    TextEditingController commentController = TextEditingController();
    void addComment() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      if (commentController.text.isNotEmpty) {
        setState(() {
          widget.comments.add(commentController.text);
        });
      }
    }

//    void toggleLike() {
//      if (widget.isLiked = true) {
//        setState(() {
//          widget.isLiked = !widget.isLiked;
//        });
//      } else if (widget.isLiked = false) {
//        setState(() {
//          widget.isLiked = !widget.isLiked;
//        });
//      }
//    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff195e83),
        title: Text("مطعم الغربال"),
      ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: new EdgeInsets.only(
//                   top: 10.0,
//                   bottom: 20.0,
//                 ),
//                 child: Center(
//                   child:
//                   SmoothStarRating(
//                     allowHalfRating: true,
//                     size: MediaQuery.of(context).size.width * 0.15,
//                     rating: rating,
//                     color: Color(0xff195e83),
//                     borderColor: Color(0xff195e83),
//                     starCount: starCount,
//                     onRated: (rating) => setState(
//                       () {
//                         rating = rating;
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Card(
//                 child: Image.network(
//                   "https://scontent.famm6-1.fna.fbcdn.net/v/t1.0-9/118286979_948523232328302_3199028525771849416_o.jpg?_nc_cat=105&ccb=2&_nc_sid=8bfeb9&_nc_eui2=AeHH28fcdxUN_wetxTxGb85mardqpGu5x9Rqt2qka7nH1Jdi8ffsEkR5wi6aoOI3L8hHMVhpKuP89DZvqPR_Qmj_&_nc_ohc=g-XkMJLD6NgAX9K66o-&_nc_ht=scontent.famm6-1.fna&oh=7e7bed51bcc75eb1b956198e612721f7&oe=601420B0",
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.6,
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'add comment',
//                       ),
//                       controller: commentController,
//                       onFieldSubmitted: (val) {
//                         addComment();
//                       },
//                     ),
//                   ),
//                   FlatButton(
//                     onPressed: () {
//                       addComment();
//                     },
//                     child: Text(
//                       'Send',
//                       style: TextStyle(fontSize: 20, color: Color(0xff195e83)),
//                     ),
//                   ),
// //                  IconButton(
// //                    onPressed: () {
// //                      setState(() {
// //                        toggleLike();
// //                      });
// //                    },
// //                    icon: widget.isLiked == true
// //                        ? Icon(Icons.thumb_up)
// //                        : Icon(Icons.thumb_down),
// //                  ),
//                 ],
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.3,
//                 child: _getScrollView(),
//                 padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width * 0.03),
//               )
// //              ...widget.comments.map((e) => Text(e)).toList(),
//             ],
//           ),
//         ),
//       ),
    );
  }

  Widget _getScrollView() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  ProfileItemWidget(
                    comment: widget.comments[index],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[400]),
                ],
              ),
            );
          },
          itemCount: widget.comments.length),
    );
  }
}
