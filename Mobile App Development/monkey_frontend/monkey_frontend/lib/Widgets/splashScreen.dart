import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screens/homeScreen.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  // final double size;

  // final double size;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _rotation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set background color to white
      child: AnimatedBuilder(
          animation: _rotation,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _rotation.value * pi * 2,
              child: child,
            );
          },
          child: Container(
            height: 10,
            width: 10,
            child: SvgPicture.asset(
              'assets/loading.svg',
              height: 10,
              width: 10,
            ),
          )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
