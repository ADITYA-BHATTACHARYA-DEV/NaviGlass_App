import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  // Vibrant color palette
  final Color _primaryBlue = Color(0xFF2962FF);
  final Color _electricGreen = Color(0xFF00E676);
  final Color _vibrantRed = Color(0xFFFF3D00);
  final Color _sunshineYellow = Color(0xFFFFEA00);
  final Color _deepPurple = Color(0xFF6200EA);
  final Color _spaceBlack = Color(0xFF121212);

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
      backgroundColor: _spaceBlack,
      body: Stack(
        children: [
          _buildSpaceBackground(context),
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
                  _buildAppBar(isSmallScreen),
                  SizedBox(height: screenHeight * 0.03),
                  _buildMetricsGrid(isSmallScreen),
                  SizedBox(height: screenHeight * 0.04),
                  _buildSectionHeader("RECENT ACTIVITY", _primaryBlue),
                  SizedBox(height: 12),
                  _buildRecentActivity(),
                  SizedBox(height: screenHeight * 0.04),
                  _buildSectionHeader("FAVORITE LOCATIONS", _electricGreen),
                  SizedBox(height: 12),
                  _buildFavoriteLocations(isSmallScreen),
                  SizedBox(height: screenHeight * 0.04),
                  _buildSectionHeader("SYSTEM CONTROLS", _vibrantRed),
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
            _deepPurple.withOpacity(0.9),
            _spaceBlack,
          ],
        ),
      ),
      child: Stack(
        children: [
          for (int i = 0; i < 100; i++)
            Positioned(
              left: Random().nextDouble() * size.width,
              top: Random().nextDouble() * size.height,
              child: Container(
                width: Random().nextDouble() * 3 + 1,
                height: Random().nextDouble() * 3 + 1,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(Random().nextDouble()),
                  shape: BoxShape.circle,
                ),
              ),
            ),
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
                    _primaryBlue.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -size.width * 0.2,
            bottom: -size.height * 0.2,
            child: Container(
              width: size.width * 0.6,
              height: size.width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _electricGreen.withOpacity(0.1),
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
          icon: Icon(LucideIcons.chevronLeft,
              color: Colors.white, size: isSmallScreen ? 24 : 28),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: isSmallScreen ? 8 : 12),
        Text(
          " CONTROL PANEL ",
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallScreen ? 18 : 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                color: _primaryBlue.withOpacity(0.5),
                blurRadius: 10,
              ),
            ],
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
          color: _primaryBlue,
          size: isSmallScreen ? 70 : 80,
        ),
        _buildMetricCircle(
          icon: LucideIcons.messageSquare,
          value: _questionsAsked,
          label: "Questions Asked",
          color: _electricGreen,
          size: isSmallScreen ? 70 : 80,
        ),
        _buildMetricCircle(
          icon: LucideIcons.map,
          value: _distanceCovered,
          label: "Distance (km)",
          color: _vibrantRed,
          isDecimal: true,
          size: isSmallScreen ? 70 : 80,
        ),
        _buildMetricCircle(
          icon: LucideIcons.user,
          value: _activeSessions,
          label: "Active Sessions",
          color: _sunshineYellow,
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
            color.withOpacity(0.5),
            color.withOpacity(0.1),
          ],
        ),
        border: Border.all(color: color.withOpacity(0.8), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: size * 0.3, color: Colors.white),
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

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        shadows: [
          Shadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primaryBlue.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildActivityTile(
            icon: LucideIcons.clock,
            title: "Last Session",
            value: "32 minutes",
            time: "Today, 14:30",
            color: _primaryBlue,
          ),
          Divider(color: _primaryBlue.withOpacity(0.1), height: 1),
          _buildActivityTile(
            icon: LucideIcons.mapPin,
            title: "Last Location",
            value: _recentLocations[0],
            time: "Today, 14:15",
            color: _electricGreen,
          ),
          Divider(color: _electricGreen.withOpacity(0.1), height: 1),
          _buildActivityTile(
            icon: LucideIcons.search,
            title: "Last Query",
            value: "About black holes",
            time: "Today, 14:05",
            color: _vibrantRed,
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
    required Color color,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
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
          _buildLocationCard("Dwarka Colony", LucideIcons.globe, _primaryBlue),
          SizedBox(width: 12),
          _buildLocationCard("Kumbh Mela", LucideIcons.moon, _electricGreen),
          SizedBox(width: 12),
          _buildLocationCard("Prayagraj", LucideIcons.orbit, _vibrantRed),
          SizedBox(width: 12),
          _buildLocationCard("Lleida", LucideIcons.star, _sunshineYellow),
        ],
      ),
    );
  }

  Widget _buildLocationCard(String name, IconData icon, Color color) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.3),
            _spaceBlack.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemControls(bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildControlButton("RESTART", LucideIcons.rotateCcw, _vibrantRed),
        _buildControlButton("SYNC", LucideIcons.refreshCcw, _electricGreen),
        _buildControlButton("LOG OUT", LucideIcons.logOut, _primaryBlue),
      ],
    );
  }

  Widget _buildControlButton(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}