import 'package:flutter/material.dart';

class DeviceConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect Glasses")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Glasses Connected!")));
          },
          child: Text("Connect", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
