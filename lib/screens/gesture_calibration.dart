import 'package:flutter/material.dart';

class GestureCalibrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gesture Calibration")),
      body: Center(
        child: Text("Tilt your head to calibrate...", style: TextStyle(fontSize: 18, color: Colors.white70)),
      ),
    );
  }
}
