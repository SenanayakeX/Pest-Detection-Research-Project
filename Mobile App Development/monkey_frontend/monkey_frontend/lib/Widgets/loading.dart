import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screens/homeScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loading extends ProgressIndicator {
  final double size;

  const Loading({
    Key? key,
    this.size = 50.0,
    Animation<Color?>? valueColor,
    String? semanticsLabel,
    String? semanticsValue,
  }) : super(
          key: key,
          value: null,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  @override
  _LoadingState createState() => _LoadingState();

  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? Theme.of(context).primaryColor;
}

class _LoadingState extends State<Loading>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
        upperBound: 1,
        animationBehavior: AnimationBehavior.preserve);
    _rotation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat();

    // Delay navigation to the next page after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Wrap Center with Container
      color: Colors.white, // Set background color to white
      child: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _rotation,
              child: SvgPicture.asset(
                'assets/loading.svg',
                height: widget.size * 3, // Increase the size here
                width: widget.size * 3,  // Increase the size here
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _rotation.value * pi * 2,
                  child: child,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}