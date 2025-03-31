import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.black])),
            child: Text("Navigation", style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            leading: Icon(Icons.control_camera, color: Colors.cyanAccent),
            title: Text("Control Panel", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushNamed(context, "/controlPanel");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.cyanAccent),
            title: Text("Settings", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushNamed(context, "/settings");
            },
          ),
        ],
      ),
    );
  }
}
