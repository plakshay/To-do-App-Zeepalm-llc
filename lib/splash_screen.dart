import 'package:flutter/material.dart';
import 'package:todoapp/view/home/home_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //rgba(38,38,38,255)
      backgroundColor: Color.fromRGBO(38, 38, 38, 255),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/img/zeelogo1.png",
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
