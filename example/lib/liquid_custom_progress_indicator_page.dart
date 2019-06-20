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
          shapePath: _buildPath(),
        ),
      ),
    );
  }

  Path _buildPath() {
    return Path()
      ..lineTo(75, 0)
      ..lineTo(60, 100)
      ..lineTo(15, 100)
      ..close();
  }
}
