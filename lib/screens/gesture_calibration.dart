import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GestureCalibrationScreen extends StatefulWidget {
  @override
  _GestureCalibrationScreenState createState() => _GestureCalibrationScreenState();
}

class _GestureCalibrationScreenState extends State<GestureCalibrationScreen> {
  double _calibrationProgress = 0.0;
  double _sensitivity = 0.7;
  double _cameraDistance = 5.0; // in meters
  bool _isCalibrating = false;
  String _calibrationStatus = "Ready to calibrate";

  void _startCalibration() {
    setState(() {
      _isCalibrating = true;
      _calibrationStatus = "Calibrating...";
      _calibrationProgress = 0.0;
    });

    // Simulate calibration progress
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Space background
          _buildSpaceBackground(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(LucideIcons.chevronLeft, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          "GESTURE CALIBRATION",
          style: TextStyle(
            color: Colors.purpleAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(width: 48), // Balance the row
      ],
    );
  }

  Widget _buildSpaceBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade900.withOpacity(0.8),
            Colors.black,
          ],
        ),
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
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "For optimal experience, please calibrate your head movements in a well-lit environment.",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(LucideIcons.move, color: Colors.purpleAccent), // Replaced move3D with move
                title: Text("Move your head slowly", style: TextStyle(color: Colors.white)),
                subtitle: Text("Look left, right, up and down", style: TextStyle(color: Colors.white70)),
              ),
              ListTile(
                leading: Icon(LucideIcons.lightbulb, color: Colors.purpleAccent),
                title: Text("Ensure proper lighting", style: TextStyle(color: Colors.white)),
                subtitle: Text("Avoid direct light sources", style: TextStyle(color: Colors.white70)),
              ),
              ListTile(
                leading: Icon(LucideIcons.ruler, color: Colors.purpleAccent),
                title: Text("Maintain 1-2 meters distance", style: TextStyle(color: Colors.white)),
                subtitle: Text("From your device camera", style: TextStyle(color: Colors.white70)),
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
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        LinearProgressIndicator(
          value: _calibrationProgress,
          backgroundColor: Colors.blueGrey.shade800,
          color: Colors.purpleAccent,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
        SizedBox(height: 10),
        Text(
          _calibrationStatus,
          style: TextStyle(
            color: _isCalibrating ? Colors.blueAccent : Colors.greenAccent,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isCalibrating ? null : _startCalibration,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          ),
          child: Text(
            _isCalibrating ? "Calibrating..." : "Start Calibration",
            style: TextStyle(fontSize: 16),
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
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
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
              Divider(color: Colors.purpleAccent.withOpacity(0.1)),
              _buildSliderSetting(
                icon: LucideIcons.ruler,
                title: "Camera Distance (${_cameraDistance.toStringAsFixed(1)}m)",
                value: _cameraDistance,
                min: 0.5,
                max: 10.0,
                divisions: 19,
                onChanged: (value) => setState(() => _cameraDistance = value),
              ),
              Divider(color: Colors.purpleAccent.withOpacity(0.1)),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Enable Head Tracking", style: TextStyle(color: Colors.white)),
                subtitle: Text("Use head movements for navigation", style: TextStyle(color: Colors.white70)),
                secondary: Icon(LucideIcons.move, color: Colors.purpleAccent), // Replaced move3D with move
                value: true,
                activeColor: Colors.purpleAccent,
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
          Icon(icon, color: Colors.purpleAccent),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white)),
                Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: divisions,
                  activeColor: Colors.purpleAccent,
                  inactiveColor: Colors.blueGrey.shade800,
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
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              _buildGestureTip(
                icon: LucideIcons.moveHorizontal,
                title: "Horizontal Movement",
                description: "Tilt head left/right to pan view",
              ),
              _buildGestureTip(
                icon: LucideIcons.moveVertical,
                title: "Vertical Movement",
                description: "Tilt head up/down to adjust elevation",
              ),
              _buildGestureTip(
                icon: LucideIcons.zoomIn,
                title: "Zoom Control",
                description: "Lean forward/backward to zoom in/out",
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
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.purpleAccent),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(height: 5),
                Text(description, style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}