import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SpaceDashboard extends StatelessWidget {
  final Color _primaryColor = Color(0xFF6C63FF); // Soft purple
  final Color _secondaryColor = Color(0xFF4A90E2); // Muted blue
  final Color _accentColor = Color(0xFF00BFA5); // Teal
  final Color _neutralDark = Color(0xFF121212); // Dark background
  final Color _neutralLight = Color(0xFFF5F5F5); // Light text/icons
  final Color _cardBg = Color(0xFF1E1E1E); // Card background

  final List<Color> _iconColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: _neutralDark,
      body: Stack(
        children: [
          _buildSpaceBackground(context),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 24,
              vertical: 16,
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                _buildAppBar(isSmallScreen),
                SizedBox(height: screenHeight * 0.03),
                _buildWeatherCard(isSmallScreen),
                SizedBox(height: screenHeight * 0.03),
                _buildRecentPlaces(context, isSmallScreen),
                SizedBox(height: screenHeight * 0.03),
                _buildQueryHistory(isSmallScreen),
                SizedBox(height: screenHeight * 0.03),
                _buildAboutSection(isSmallScreen),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Profile Dashboard",
            style: TextStyle(
              color: _neutralLight,
              fontSize: isSmallScreen ? 20 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            radius: isSmallScreen ? 20 : 24,
            backgroundColor: _primaryColor.withOpacity(0.2),
            child: Icon(
              LucideIcons.user,
              color: Colors.pinkAccent,
              size: isSmallScreen ? 24 : 28,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherCard(bool isSmallScreen) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primaryColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Local Weather",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: isSmallScreen ? 12 : 14,
                    letterSpacing: 1.5,
                  )),
              Icon(LucideIcons.cloud,
                  color: Colors.orangeAccent, size: isSmallScreen ? 18 : 20),
            ],
          ),
          SizedBox(height: 12),
          Text("Current Conditions",
              style: TextStyle(
                  color: _neutralLight,
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: isSmallScreen ? 16 : 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeatherMetric(
                icon: LucideIcons.sun,
                value: "Daylight: Low",
                color: Colors.yellowAccent,
                isSmallScreen: isSmallScreen,
              ),
              _buildWeatherMetric(
                icon: LucideIcons.waves,
                value: "Humidity: 8%",
                color: Colors.tealAccent,
                isSmallScreen: isSmallScreen,
              ),
              _buildWeatherMetric(
                icon: LucideIcons.compass,
                value: "Wind: Stable",
                color: Colors.blueAccent,
                isSmallScreen: isSmallScreen,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherMetric({
    required IconData icon,
    required String value,
    required Color color,
    required bool isSmallScreen,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: isSmallScreen ? 20 : 24),
        SizedBox(height: 8),
        Text(value,
            style: TextStyle(
                color: _neutralLight, fontSize: isSmallScreen ? 12 : 14)),
      ],
    );
  }

  Widget _buildRecentPlaces(BuildContext context, bool isSmallScreen) {
    final recentPlaces = [
      {"name": "Lleida", "date": "Today", "icon": LucideIcons.globe},
      {"name": "Dwarka Colony", "date": "Yesterday", "icon": LucideIcons.mapPin},
      {"name": "Prayagraj", "date": "2 days ago", "icon": LucideIcons.moon},
      {"name": "Kumbh Mela", "date": "1 week ago", "icon": LucideIcons.circle},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("RECENTLY VISITED",
            style: TextStyle(
              color: Colors.purpleAccent,
              fontSize: isSmallScreen ? 12 : 14,
              letterSpacing: 1.5,
            )),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primaryColor.withOpacity(0.2)),
          ),
          child: Column(
            children: recentPlaces.asMap().entries.map((entry) {
              int index = entry.key;
              var place = entry.value;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _iconColors[index % _iconColors.length]
                      .withOpacity(0.2),
                  child: Icon(
                    place["icon"] as IconData,
                    color: _iconColors[index % _iconColors.length],
                  ),
                ),
                title: Text(place["name"]! as String,
                    style: TextStyle(color: _neutralLight)),
                subtitle: Text(place["date"]! as String,
                    style: TextStyle(color: _neutralLight.withOpacity(0.6))),
                trailing: Icon(LucideIcons.chevronRight,
                    color: Colors.white24, size: 18),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQueryHistory(bool isSmallScreen) {
    final queries = [
      {"query": "Show shops near Delhi", "response": "Found 3 candidates"},
      {"query": "Direction to move", "response": "Position displayed"},
      {"query": "What I am looking at it?", "response": "April 8, 2024"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("RECENT QUERIES",
            style: TextStyle(
                color: Colors.lightGreenAccent,
                fontSize: isSmallScreen ? 12 : 14,
                letterSpacing: 1.5)),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primaryColor.withOpacity(0.2)),
          ),
          child: Column(
            children: queries.map((query) {
              return Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(LucideIcons.mic, color: Colors.redAccent, size: 16),
                      SizedBox(width: 6),
                      Text("You asked:",
                          style: TextStyle(
                              color: Colors.redAccent.withOpacity(0.7),
                              fontSize: isSmallScreen ? 12 : 14)),
                    ]),
                    Text(query["query"]! as String,
                        style: TextStyle(color: _neutralLight)),
                    SizedBox(height: 8),
                    Row(children: [
                      Icon(LucideIcons.star, color: Colors.amberAccent),
                      SizedBox(width: 6),
                      Text("Response:",
                          style: TextStyle(
                              color: Colors.amberAccent.withOpacity(0.7),
                              fontSize: isSmallScreen ? 12 : 14)),
                    ]),
                    Text(query["response"]! as String,
                        style: TextStyle(color: _neutralLight)),
                    if (query != queries.last) Divider(color: Colors.white12)
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ABOUT NAVIGLASS",
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: isSmallScreen ? 12 : 14,
                letterSpacing: 1.5)),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primaryColor.withOpacity(0.2)),
          ),
          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
          child: Column(
            children: [
              Text(
                "Explore the World with our Liquid Galaxy integration. Navigate through directions, view places and monuments, and get real-time vision data all in one place.",
                style: TextStyle(
                    color: _neutralLight,
                    height: 1.5,
                    fontSize: isSmallScreen ? 14 : 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeatureIcon(
                      LucideIcons.globe, "Location", Colors.greenAccent, isSmallScreen),
                  _buildFeatureIcon(
                      LucideIcons.satellite, "Tracking", Colors.orangeAccent, isSmallScreen),
                  _buildFeatureIcon(
                      LucideIcons.database, "3D Models", Colors.cyanAccent, isSmallScreen),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureIcon(
      IconData icon, String label, Color color, bool isSmallScreen) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: color.withOpacity(0.15), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 6),
        Text(label,
            style: TextStyle(
                color: _neutralLight, fontSize: isSmallScreen ? 12 : 14)),
      ],
    );
  }

  Widget _buildSpaceBackground(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _neutralDark,
            Color(0xFF2D1B4D).withOpacity(0.5),
            _neutralDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          for (int i = 0; i < 100; i++)
            Positioned(
              left: Random().nextDouble() * screenWidth,
              top: Random().nextDouble() * screenHeight,
              child: Container(
                width: Random().nextDouble() * 2 + 1,
                height: Random().nextDouble() * 2 + 1,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(Random().nextDouble()),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
