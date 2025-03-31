import 'package:flutter/material.dart';

import 'screens/about_screen.dart';
import 'screens/control_panel.dart';
import 'screens/gesture_calibration.dart';
import 'screens/head_tracking_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings.dart';
import 'screens/splash_screen.dart';
import 'screens/voice_control.dart';

void main() {
  runApp(SpaceControlApp());
}

class SpaceControlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/home": (context) => HomeScreen(),
        "/controlPanel": (context) => ControlPanel(),
        "/settings": (context) => SettingsScreen(),
        "/voiceControl": (context) => VoiceControlScreen(),
        "/headTracking": (context) => HeadTrackingScreen(),
        "/about": (context) => SpaceDashboard(),
         "/gestureTracking": (context) => GestureCalibrationScreen(),
      },
    );
  }
}
