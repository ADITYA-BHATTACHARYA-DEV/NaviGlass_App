import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HeadTrackingScreen extends StatefulWidget {
  @override
  _HeadTrackingScreenState createState() => _HeadTrackingScreenState();
}

class _HeadTrackingScreenState extends State<HeadTrackingScreen> {
  // Cosmic palette with extra vibrant accents
  final Color _primaryColor = Color(0xFF8E2DE2);
  final Color _secondaryColor = Color(0xFF4A00E0);
  final Color _bgColor = Color(0xFF090E16);
  final Color _textColor = Colors.white;

  // Icon-specific vibrant colors
  final Color _mintAccent = Color(0xFF00F5A0);
  final Color _pinkAccent = Color(0xFFFF61A6);
  final Color _blueAccent = Color(0xFF50C7F8);
  final Color _orangeAccent = Color(0xFFFFC300);
  final Color _redAccent = Color(0xFFFF6B6B);

  bool _isTrackingEnabled = true;
  bool _showFPV = false;
  double _sensitivity = 0.7;
  double _responseDelay = 0.3;
  double _zoomSensitivity = 0.5;
  String _selectedViewMode = "First-Person";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          // Cosmic background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_primaryColor.withOpacity(0.6), _bgColor],
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
                      icon: Icon(LucideIcons.chevronLeft, color: _textColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "HEAD TRACKING",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // FPV Preview
                _buildFPVSection(),

                SizedBox(height: 30),

                // View Mode
                Text("VIEW MODE",
                    style: TextStyle(
                        color: _mintAccent, fontSize: 14, letterSpacing: 1.5)),
                SizedBox(height: 10),
                _buildDropdown(),

                SizedBox(height: 30),

                // Sliders
                _buildSliderControl("Head Movement Sensitivity", _sensitivity,
                    LucideIcons.activity, _mintAccent,
                    (v) => setState(() => _sensitivity = v)),
                _buildSliderControl("Response Delay", _responseDelay,
                    LucideIcons.clock, _blueAccent,
                    (v) => setState(() => _responseDelay = v)),
                _buildSliderControl("Zoom Sensitivity", _zoomSensitivity,
                    LucideIcons.zoomIn, _orangeAccent,
                    (v) => setState(() => _zoomSensitivity = v)),

                SizedBox(height: 30),

                // Tracking Controls
                _buildControlSection(
                  title: "TRACKING CONTROLS",
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Enable Head Tracking",
                          style: TextStyle(color: _textColor)),
                      subtitle: Text("Use head movements for navigation",
                          style:
                              TextStyle(color: _textColor.withOpacity(0.7))),
                      value: _isTrackingEnabled,
                      activeColor: _mintAccent,
                      onChanged: (value) =>
                          setState(() => _isTrackingEnabled = value),
                    ),
                    Divider(color: _mintAccent.withOpacity(0.1)),
                    ListTile(
                      leading: Icon(LucideIcons.rotateCcw, color: _redAccent),
                      title: Text("Recalibrate Tracking",
                          style: TextStyle(color: _textColor)),
                      trailing: Icon(LucideIcons.chevronRight,
                          color: _textColor.withOpacity(0.5)),
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

  Widget _buildFPVSection() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _bgColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _mintAccent.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: _mintAccent.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _showFPV ? LucideIcons.eye : LucideIcons.eyeOff,
            size: 40,
            color: _showFPV ? _mintAccent : Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            _showFPV ? "FPV ACTIVE" : "FPV DISABLED",
            style: TextStyle(
              color: _showFPV ? _mintAccent : Colors.grey,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() => _showFPV = !_showFPV),
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                _showFPV ? "DISABLE FPV" : "ENABLE FPV",
                style: TextStyle(color: _textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _bgColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _mintAccent.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: _mintAccent.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: _selectedViewMode,
        dropdownColor: _bgColor,
        isExpanded: true,
        underline: SizedBox(),
        items: [
          "First-Person",
          "Third-Person",
          "Orbital",
          "Fixed Camera",
        ]
            .map((mode) => DropdownMenuItem(
                  value: mode,
                  child: Text(mode, style: TextStyle(color: _textColor)),
                ))
            .toList(),
        onChanged: (value) => setState(() => _selectedViewMode = value!),
      ),
    );
  }

  Widget _buildSliderControl(
    String label,
    double value,
    IconData icon,
    Color iconColor,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: _textColor)),
                Slider(
                  value: value,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  activeColor: iconColor,
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

  Widget _buildControlSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: _mintAccent,
            fontSize: 14,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _bgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _mintAccent.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: _mintAccent.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  void _showCalibrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _mintAccent.withOpacity(0.3)),
        ),
        title: Text("Calibration", style: TextStyle(color: _textColor)),
        content: Text(
          "Follow the on-screen prompts to calibrate your head tracking.",
          style: TextStyle(color: _textColor.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL", style: TextStyle(color: _mintAccent)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("BEGIN", style: TextStyle(color: _textColor)),
          ),
        ],
      ),
    );
  }
}
