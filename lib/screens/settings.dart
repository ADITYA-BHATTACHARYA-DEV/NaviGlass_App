import 'dart:math';

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SSH Settings'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background starry effect
          Positioned.fill(
            child: AnimatedContainer(
              duration: Duration(seconds: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade900, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomPaint(
                painter: StarryBackgroundPainter(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title text
                Text(
                  'Configure SSH Connection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 30),

                // Input fields with space-themed styling
                _buildTextField(_ipController, 'IP Address', Icons.network_wifi),
                _buildTextField(_portController, 'Port', Icons.portable_wifi_off),
                _buildTextField(_usernameController, 'Username', Icons.person),
                _buildTextField(_passwordController, 'Password', Icons.lock, obscureText: true),
                SizedBox(height: 20),

                // Buttons with hover effects and futuristic design
                Center(
                  child: Wrap(
                    spacing: 20, // Horizontal space between buttons
                    runSpacing: 20, // Vertical space between buttons
                    alignment: WrapAlignment.center,
                    children: [
                      _buildButton('Connect', Colors.blueAccent, () {}),
                      _buildButton('Disconnect', Colors.redAccent, () {}),
                      _buildButton('Test Connection', Colors.greenAccent, () {}),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Connection status display
                Center(
                  child: AnimatedDefaultTextStyle(
                    style: TextStyle(
                      color: isConnected ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      isConnected ? 'Connected' : 'Disconnected',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Text Field with space-themed styling
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purpleAccent.withOpacity(0.7)),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(icon, color: Colors.white70),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ),
    );
  }

  // Dynamic button with hover effects
  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.5)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Custom painter for starry background
class StarryBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    final random = Random();

    // Draw random stars
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
