import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GestureCalibrationScreen extends StatefulWidget {
  @override
  _GestureCalibrationScreenState createState() =>
      _GestureCalibrationScreenState();
}

class _GestureCalibrationScreenState extends State<GestureCalibrationScreen> {
  // Color palette
  final Color _primaryColor = Color(0xFF6A11CB); // Deep purple
  final Color _secondaryColor = Color(0xFF2575FC); // Vibrant blue
  final Color _accentColor = Color(0xFF00F2FE); // Cyan
  final Color _successColor = Color(0xFF00E676); // Green
  final Color _warningColor = Color(0xFFFFC400); // Yellow
  final Color _bgColor = Color(0xFF0F0F1B); // Dark navy
  final Color _textColor = Colors.white;

  double _calibrationProgress = 0.0;
  double _sensitivity = 0.7;
  double _cameraDistance = 5.0;
  bool _isCalibrating = false;
  String _calibrationStatus = "Ready to calibrate";

  void _startCalibration() {
    setState(() {
      _isCalibrating = true;
      _calibrationStatus = "Calibrating...";
      _calibrationProgress = 0.0;
    });

    const calibrationDuration = Duration(seconds: 3);
    final calibrationSteps = calibrationDuration.inMilliseconds ~/ 100;

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _calibrationProgress += 1 / calibrationSteps;
        if (_calibrationProgress >= 1.0) {
          _calibrationProgress = 1.0;
          _calibrationStatus = "Calibration Complete!";
          _isCalibrating = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _primaryColor.withOpacity(0.8),
                  _bgColor,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                SizedBox(height: 30),
                _buildCalibrationGuide(),
                SizedBox(height: 40),
                _buildCalibrationProgress(),
                SizedBox(height: 40),
                _buildControlSettings(),
                SizedBox(height: 30),
                _buildNavigationTips(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(LucideIcons.chevronLeft, color: _textColor, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              "GESTURE CALIBRATION",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _accentColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildCalibrationGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Head Tracking Setup",
          style: TextStyle(
            color: _textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "For optimal experience, please calibrate your head movements in a well-lit environment.",
          style: TextStyle(color: _textColor.withOpacity(0.7), fontSize: 16),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _bgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _accentColor.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(LucideIcons.move, color: Colors.orangeAccent),
                title:
                    Text("Move your head slowly", style: TextStyle(color: _textColor)),
                subtitle: Text("Look left, right, up and down",
                    style: TextStyle(color: _textColor.withOpacity(0.7))),
              ),
              ListTile(
                leading: Icon(LucideIcons.lightbulb, color: Colors.yellow),
                title: Text("Ensure proper lighting",
                    style: TextStyle(color: _textColor)),
                subtitle: Text("Avoid direct light sources",
                    style: TextStyle(color: _textColor.withOpacity(0.7))),
              ),
              ListTile(
                leading: Icon(LucideIcons.ruler, color: Colors.redAccent),
                title: Text("Maintain 1-2 meters distance",
                    style: TextStyle(color: _textColor)),
                subtitle: Text("From your device camera",
                    style: TextStyle(color: _textColor.withOpacity(0.7))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalibrationProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Calibration Status",
          style: TextStyle(
            color: _textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        LinearProgressIndicator(
          value: _calibrationProgress,
          backgroundColor: _bgColor.withOpacity(0.7),
          color: _isCalibrating ? _warningColor : _successColor,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
        SizedBox(height: 10),
        Text(
          _calibrationStatus,
          style: TextStyle(
            color: _isCalibrating ? _warningColor : _successColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: _isCalibrating ? null : _startCalibration,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
            child: Text(
              _isCalibrating ? "Calibrating..." : "Start Calibration",
              style: TextStyle(fontSize: 16, color: _textColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Control Settings",
          style: TextStyle(
            color: _textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _bgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _accentColor.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              _buildSliderSetting(
                icon: LucideIcons.activity,
                title: "Gesture Sensitivity",
                value: _sensitivity,
                min: 0.1,
                max: 1.0,
                onChanged: (value) => setState(() => _sensitivity = value),
              ),
              Divider(color: _accentColor.withOpacity(0.1)),
              _buildSliderSetting(
                icon: LucideIcons.ruler,
                title: "Camera Distance (${_cameraDistance.toStringAsFixed(1)}m)",
                value: _cameraDistance,
                min: 0.5,
                max: 10.0,
                divisions: 19,
                onChanged: (value) => setState(() => _cameraDistance = value),
              ),
              Divider(color: _accentColor.withOpacity(0.1)),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title:
                    Text("Enable Head Tracking", style: TextStyle(color: _textColor)),
                subtitle: Text("Use head movements for navigation",
                    style: TextStyle(color: _textColor.withOpacity(0.7))),
                secondary: Icon(LucideIcons.move, color: Colors.greenAccent),
                value: true,
                activeColor: _successColor,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliderSetting({
    required IconData icon,
    required String title,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    int? divisions,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: _accentColor),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _textColor)),
                Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: divisions,
                  activeColor: _accentColor,
                  inactiveColor: _bgColor.withOpacity(0.7),
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Navigation Tips",
          style: TextStyle(
            color: _textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _bgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _accentColor.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              _buildGestureTip(
                icon: LucideIcons.moveHorizontal,
                title: "Horizontal Movement",
                description: "Tilt head left/right to pan view",
                color: Colors.orange,
              ),
              _buildGestureTip(
                icon: LucideIcons.moveVertical,
                title: "Vertical Movement",
                description: "Tilt head up/down to adjust elevation",
                color: Colors.green,
              ),
              _buildGestureTip(
                icon: LucideIcons.zoomIn,
                title: "Zoom Control",
                description: "Lean forward/backward to zoom in/out",
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGestureTip({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(color: _textColor, fontSize: 16)),
                SizedBox(height: 5),
                Text(description,
                    style: TextStyle(color: _textColor.withOpacity(0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
