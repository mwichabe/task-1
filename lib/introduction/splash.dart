import 'package:flutter/material.dart';
import 'package:task/constant/constant.dart';
import 'package:task/introduction/login/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _containerSize = 100.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _containerSize = 300.0;
    });

    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LogIn(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ConstanceData.splashBg),
                      ),
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        width: _containerSize,
                        height: _containerSize,
                        child: ClipOval(child: Image.asset(ConstanceData.logo)),
                      ),
                   ))));
  }
}