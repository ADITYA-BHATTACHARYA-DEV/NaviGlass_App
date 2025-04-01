import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  // Sample data
  final int _placesVisited = 42;
  final int _questionsAsked = 28;
  final double _distanceCovered = 127.5;
  final int _activeSessions = 3;
  final List<String> _recentLocations = [
    "New Delhi, India",
    "Orion Nebula",
    "Black Hole X-12"
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated Space Background
          _buildSpaceBackground(context),
          
          // Safe area to avoid camera notch
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: isSmallScreen ? 16 : 24,
                right: isSmallScreen ? 16 : 24,
                top: 16,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with proper spacing
                  _buildAppBar(isSmallScreen),
                  SizedBox(height: screenHeight * 0.03),

                  // Main Metrics Grid
                  _buildMetricsGrid(isSmallScreen),
                  SizedBox(height: screenHeight * 0.04),

                  // Recent Activity Section
                  _buildSectionHeader("RECENT ACTIVITY"),
                  SizedBox(height: 12),
                  _buildRecentActivity(),
                  SizedBox(height: screenHeight * 0.04),

                  // Favorite Locations
                  _buildSectionHeader("FAVORITE LOCATIONS"),
                  SizedBox(height: 12),
                  _buildFavoriteLocations(isSmallScreen),
                  SizedBox(height: screenHeight * 0.04),

                  // System Controls
                  _buildSectionHeader("SYSTEM CONTROLS"),
                  SizedBox(height: 12),
                  _buildSystemControls(isSmallScreen),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpaceBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade900.withOpacity(0.9),
            Colors.black,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Stars
          for (int i = 0; i < 50; i++)
            Positioned(
              left: Random().nextDouble() * size.width,
              top: Random().nextDouble() * size.height,
              child: Container(
                width: Random().nextDouble() * 2 + 1,
                height: Random().nextDouble() * 2 + 1,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(Random().nextDouble() * 0.8 + 0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          
          // Nebula effect
          Positioned(
            right: -size.width * 0.3,
            top: size.height * 0.1,
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.purpleAccent.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(bool isSmallScreen) {
    return Row(
      children: [
        IconButton(
          icon: Icon(LucideIcons.chevronLeft, color: Colors.white, size: isSmallScreen ? 24 : 28),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: isSmallScreen ? 8 : 12),
        Text(
          " CONTROL PANEL ",
          style: TextStyle(
            color: const Color.fromARGB(255, 252, 252, 252),
            fontSize: isSmallScreen ? 18 : 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(bool isSmallScreen) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1,
      crossAxisSpacing: isSmallScreen ? 12 : 16,
      mainAxisSpacing: isSmallScreen ? 12 : 16,
      children: [
        _buildMetricCircle(
          icon: LucideIcons.globe,
          value: _placesVisited,
          label: "Places Visited",
          color: const Color.fromARGB(255, 4, 91, 241),
          size: isSmallScreen ? 70 : 80,
        ),
        _buildMetricCircle(
          icon: LucideIcons.messageSquare,
          value: _questionsAsked,
          label: "Questions Asked",
          color: Color.fromARGB(255, 2, 255, 61),
          size: isSmallScreen ? 70 : 80,
        ),
        _buildMetricCircle(
          icon: LucideIcons.map,
          value: _distanceCovered,
          label: "Distance (km)",
          color: Color.fromARGB(255, 253, 67, 57),
          isDecimal: true,
          size: isSmallScreen ? 70 : 80,
        ),
        _buildMetricCircle(
          icon: LucideIcons.user,
          value: _activeSessions,
          label: "Active Sessions",
          color: Color.fromARGB(255, 249, 228, 3),
          size: isSmallScreen ? 70 : 80,
        ),
      ],
    );
  }

  Widget _buildMetricCircle({
    required IconData icon,
    required dynamic value,
    required String label,
    required Color color,
    bool isDecimal = false,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.3),
            color.withOpacity(0.1),
          ],
        ),
        border: Border.all(color: color.withOpacity(0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: size * 0.3, color: color),
          SizedBox(height: size * 0.1),
          Text(
            isDecimal ? value.toStringAsFixed(1) : value.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size * 0.05),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: size * 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.purpleAccent,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildActivityTile(
            icon: LucideIcons.clock,
            title: "Last Session",
            value: "32 minutes",
            time: "Today, 14:30",
          ),
          Divider(color: Colors.purpleAccent.withOpacity(0.1), height: 1),
          _buildActivityTile(
            icon: LucideIcons.mapPin,
            title: "Last Location",
            value: _recentLocations[0],
            time: "Today, 14:15",
          ),
          Divider(color: Colors.purpleAccent.withOpacity(0.1), height: 1),
          _buildActivityTile(
            icon: LucideIcons.search,
            title: "Last Query",
            value: "About black holes",
            time: "Today, 14:05",
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile({
    required IconData icon,
    required String title,
    required String value,
    required String time,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purpleAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.purpleAccent, size: 20),
      ),
      title: Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
      subtitle: Text(value, style: TextStyle(color: Colors.white, fontSize: 16)),
      trailing: Text(time, style: TextStyle(color: Colors.white54, fontSize: 12)),
    );
  }

  Widget _buildFavoriteLocations(bool isSmallScreen) {
    return SizedBox(
      height: isSmallScreen ? 100 : 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildLocationCard("Dwarka Colony", LucideIcons.globe),
          SizedBox(width: 12),
          _buildLocationCard("Kumbh Mela", LucideIcons.moon),
          SizedBox(width: 12),
          _buildLocationCard("Prayagraj", LucideIcons.orbit),
          SizedBox(width: 12),
          _buildLocationCard("Lleida", LucideIcons.star),
        ],
      ),
    );
  }

  Widget _buildLocationCard(String name, IconData icon) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.5),
            Colors.indigo.shade900.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.purpleAccent),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSystemControls(bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          child: _buildControlButton(
            icon: LucideIcons.power,
            label: "Restart System",
            color: Colors.orangeAccent,
            isSmallScreen: isSmallScreen,
          ),
        ),
        SizedBox(width: isSmallScreen ? 10 : 16),
        Expanded(
          child: _buildControlButton(
            icon: LucideIcons.settings,
            label: "Advanced Settings",
            color: Colors.purpleAccent,
            isSmallScreen: isSmallScreen,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required bool isSmallScreen,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.5), width: 1),
        ),
        padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 14 : 16),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: isSmallScreen ? 20 : 24),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: isSmallScreen ? 12 : 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}