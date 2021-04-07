import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visit_saltus/screens/home_screens/main_introduction_screen.dart';

class Splash_Screen extends StatelessWidget {
  BlendMode get blendMode => BlendMode.colorBurn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 75,
          ),
          Expanded(
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/final.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "هذي هيَ السَّلطُ في أبهى أساميها\n",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "عَروسُ ديرتِنا تُزهي مُحِبِّيها",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return MainIntroductionScreen();
                        },
                      ), (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 150),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF0C74BF),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "لِنبدأ جولتنا",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
