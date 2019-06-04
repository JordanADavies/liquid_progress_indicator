import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LiquidCustomProgressIndicatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liquid Custom Progress Indicators"),
      ),
      body: Center(
        child: LiquidCustomProgressIndicator(
          direction: Axis.vertical,
          borderColor: Colors.red,
          borderWidth: 5.0,
          shapePath: _buildPath(),
        ),
      ),
    );
  }

  Path _buildPath() {
    return Path()
      ..moveTo(50, 0)
      ..lineTo(0, 75)
      ..arcToPoint(
        Offset(100, 75), clockwise: false, radius: Radius.circular(8.0),)
      ..close();
  }
}
