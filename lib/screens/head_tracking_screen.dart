import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HeadTrackingScreen extends StatefulWidget {
  @override
  _HeadTrackingScreenState createState() => _HeadTrackingScreenState();
}

class _HeadTrackingScreenState extends State<HeadTrackingScreen> {
  bool _isTrackingEnabled = true;
  bool _showFPV = false;
  double _sensitivity = 0.7;
  double _responseDelay = 0.3;
  double _zoomSensitivity = 0.5;
  String _selectedViewMode = "First-Person";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Space-themed gradient background
          Container(
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
          ),

          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 20),
                // Header
                Row(
                  children: [
                   
                    IconButton(
                      icon: Icon(LucideIcons.chevronLeft, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "HEAD TRACKING",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // First-Person View Preview
                Container(
  height: 200,
  padding: EdgeInsets.all(16), // Added padding to prevent overflow
  decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.3),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        _showFPV ? LucideIcons.eye : LucideIcons.eyeOff,
        size: 40,
        color: _showFPV ? Colors.greenAccent : Colors.grey,
      ),
      SizedBox(height: 10),
      Text(
        _showFPV ? "FPV ACTIVE" : "FPV DISABLED",
        style: TextStyle(
          color: _showFPV ? Colors.greenAccent : Colors.grey,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 15), // Adjusted spacing
      SizedBox(
        width: double.infinity, // Makes button expand properly inside container
        child: ElevatedButton(
          onPressed: () => setState(() => _showFPV = !_showFPV),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12), // Proper padding for button text
          ),
          child: Text(
            _showFPV ? "DISABLE FPV" : "ENABLE FPV",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  ),
),

                SizedBox(height: 30),

                // View Mode Selection
                Text(
                  "VIEW MODE",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedViewMode,
                    dropdownColor: Colors.deepPurple.shade900,
                    isExpanded: true,
                    underline: SizedBox(),
                    items: [
                      "First-Person",
                      "Third-Person",
                      "Orbital",
                      "Fixed Camera",
                    ].map((mode) => DropdownMenuItem(
                      value: mode,
                      child: Text(mode, style: TextStyle(color: Colors.white)),
                    )).toList(),
                    onChanged: (value) => setState(() => _selectedViewMode = value!),
                  ),
                ),
                SizedBox(height: 30),

                // Sensitivity Controls
                _buildSliderControl("Head Movement Sensitivity", _sensitivity, LucideIcons.activity, (v) => setState(() => _sensitivity = v)),
                _buildSliderControl("Response Delay", _responseDelay, LucideIcons.clock, (v) => setState(() => _responseDelay = v)),
                _buildSliderControl("Zoom Sensitivity", _zoomSensitivity, LucideIcons.zoomIn, (v) => setState(() => _zoomSensitivity = v)),

                SizedBox(height: 30),

                // Tracking Controls
                _buildControlSection(
                  title: "TRACKING CONTROLS",
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Enable Head Tracking", style: TextStyle(color: Colors.white)),
                      subtitle: Text("Use head movements for navigation", style: TextStyle(color: Colors.white70)),
                      value: _isTrackingEnabled,
                      activeColor: Colors.purpleAccent,
                      onChanged: (value) => setState(() => _isTrackingEnabled = value),
                    ),
                    Divider(color: Colors.purpleAccent.withOpacity(0.1)),
                    ListTile(
                      leading: Icon(LucideIcons.rotateCcw, color: Colors.purpleAccent),
                      title: Text("Recalibrate Tracking", style: TextStyle(color: Colors.white)),
                      trailing: Icon(LucideIcons.chevronRight, color: Colors.white54),
                      onTap: () => _showCalibrationDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderControl(String label, double value, IconData icon, ValueChanged<double> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.white)),
                Slider(
                  value: value,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
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

  Widget _buildControlSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.purpleAccent,
            fontSize: 14,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  void _showCalibrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade900,
        title: Text("Calibration", style: TextStyle(color: Colors.white)),
        content: Text("Follow the on-screen prompts to calibrate your head tracking", 
          style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL", style: TextStyle(color: Colors.purpleAccent)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
            child: Text("BEGIN", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
