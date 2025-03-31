import 'package:flutter/material.dart';

class HeadTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Head Tracking")),
      body: Center(child: Text("Use Head Movements for Navigation")),
    );
  }
}
