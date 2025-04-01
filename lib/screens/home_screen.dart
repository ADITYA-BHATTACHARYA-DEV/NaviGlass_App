import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // For space-themed icons

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Dashboard"),
        backgroundColor: Colors.black,
        elevation: 10,
        shadowColor: Colors.purpleAccent.withOpacity(0.5),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildFeatureTile(context, "Control Panel", "/controlPanel", LucideIcons.cpu, Colors.deepPurpleAccent),
            _buildFeatureTile(context, "Settings", "/settings", LucideIcons.settings, Colors.blueAccent),
            _buildFeatureTile(context, "Voice Control", "/voiceControl", LucideIcons.mic, Colors.tealAccent),
            _buildFeatureTile(context, "Head Tracking", "/headTracking", LucideIcons.scanFace
            , Colors.pinkAccent),
                        _buildFeatureTile(context, "Gesture Control", "/gestureTracking", LucideIcons.eye, Color.fromARGB(255, 3, 249, 3)),
            _buildFeatureTile(context, "About", "/about", LucideIcons.info, Colors.orangeAccent),
            _buildFeatureTile(context, "Show KMLs", "/about", LucideIcons.bellRing, Color.fromARGB(255, 200, 0, 255)),
            _buildFeatureTile(context, "Add KMLs", "/about", LucideIcons.bookMarked, Color.fromARGB(255, 254, 3, 171)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context, String title, String route, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.6), blurRadius: 15, spreadRadius: 2),
          ],
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
