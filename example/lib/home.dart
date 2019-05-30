import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Scaffold(
      body: Center(
        child: Container(
          width: 150.0,
          height: 150.0,
          child: LiquidCircularProgressIndicator(
            value: _animationController.value,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            center: Text(
              "${percentage.toStringAsFixed(0)}%",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
