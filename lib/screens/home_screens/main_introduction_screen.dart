import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:visit_saltus/screens/registration_screens/login_screen.dart';

class MainIntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(1.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "أهلاً و سهلاً بكم",
          body: "تجول في المدينة القديمة و أستكشف مساراتنا السياحية ",
          image: _buildImage('final1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "خدماتنا",
          body: "قم بزيارة المطاعم و المقاهي التراثية و الشعبية",
          image: _buildImage('final2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "تجول",
          body:
              "قم بزيارة الأحياء و المنازل القديمة لتروي لك ذكريات العديد من الأجيال ",
          image: _buildImage('final3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "احجز الآن",
          body:
              "توفير خدمة صادقة لنزلائنا وللوصول إلى تجارب سفر ذات مغزى حينما يقيمون معنا ",
          image: _buildImage('final4'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('تخطي'),
      next: const Icon(Icons.arrow_forward),
      done: const Icon(Icons.check),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
