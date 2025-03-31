import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SpaceDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Space background with stars
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 0 : 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "GALACTIC EXPLORER",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: isSmallScreen ? 10 : 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Space Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: isSmallScreen ? 20 : 24,
            backgroundColor: Colors.purpleAccent.withOpacity(0.2),
            child: Icon(
              LucideIcons.user,
              color: Colors.purpleAccent,
              size: isSmallScreen ? 18 : 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(bool isSmallScreen) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.deepPurple.shade800, Colors.indigo.shade900],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SPACE WEATHER",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: isSmallScreen ? 10 : 12,
                    letterSpacing: 1.5,
                  ),
                ),
                Icon(
                  LucideIcons.satellite,
                  color: Colors.purpleAccent,
                  size: isSmallScreen ? 18 : 20,
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "Current Conditions",
              style: TextStyle(
                color: Colors.white,
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherMetric(
                  icon: LucideIcons.sun,
                  value: "Solar Flare: Low",
                  color: Colors.orangeAccent,
                  isSmallScreen: isSmallScreen,
                ),
                _buildWeatherMetric(
                  icon: LucideIcons.waves,
                  value: "Radiation: 3.2 μSv",
                  color: Colors.greenAccent,
                  isSmallScreen: isSmallScreen,
                ),
                _buildWeatherMetric(
                  icon: LucideIcons.compass,
                  value: "Magnetic: Stable",
                  color: Colors.blueAccent,
                  isSmallScreen: isSmallScreen,
                ),
              ],
            ),
          ],
        ),
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
        Icon(
          icon,
          color: color,
          size: isSmallScreen ? 20 : 24,
        ),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPlaces(BuildContext context, bool isSmallScreen) {
    final recentPlaces = [
      {"name": "Andromeda Galaxy", "date": "Today", "icon": LucideIcons.globe},
      {"name": "Mars Colony", "date": "Yesterday", "icon": LucideIcons.mapPin},
      {"name": "Jupiter's Moons", "date": "2 days ago", "icon": LucideIcons.moon},
      {"name": "Saturn Rings", "date": "1 week ago", "icon": LucideIcons.circle},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RECENTLY VISITED",
          style: TextStyle(
            color: Colors.purpleAccent,
            fontSize: isSmallScreen ? 10 : 12,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
          ),
          child: Column(
            children: recentPlaces.map((place) => ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: 8,
              ),
              leading: Container(
                padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  place["icon"] as IconData,
                  color: Colors.purpleAccent,
                  size: isSmallScreen ? 18 : 20,
                ),
              ),
              title: Text(
                place["name"] as String,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
              subtitle: Text(
                place["date"] as String,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: isSmallScreen ? 10 : 12,
                ),
              ),
              trailing: Icon(
                LucideIcons.chevronRight,
                color: Colors.white54,
                size: isSmallScreen ? 18 : 20,
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQueryHistory(bool isSmallScreen) {
    final queries = [
      {"query": "Show black holes near Earth", "response": "Found 3 candidates"},
      {"query": "Current ISS position", "response": "Position displayed"},
      {"query": "Next solar eclipse", "response": "April 8, 2024"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RECENT QUERIES",
          style: TextStyle(
            color: Colors.purpleAccent,
            fontSize: isSmallScreen ? 10 : 12,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade900.withOpacity(0.7),
                Colors.indigo.shade900.withOpacity(0.7)
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: queries.map((query) => Padding(
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mic,
                        color: Colors.purpleAccent,
                        size: isSmallScreen ? 14 : 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "You asked:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isSmallScreen ? 10 : 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    query["query"] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.star,
                        color: Colors.blueAccent,
                        size: isSmallScreen ? 14 : 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Response:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isSmallScreen ? 10 : 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    query["response"] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                  if (query != queries.last) 
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 8 : 12),
                      child: Divider(
                        color: Colors.purpleAccent.withOpacity(0.1),
                        height: 1,
                      ),
                    ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ABOUT GALACTIC EXPLORER",
          style: TextStyle(
            color: Colors.purpleAccent,
            fontSize: isSmallScreen ? 10 : 12,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
          ),
          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
          child: Column(
            children: [
              Text(
                "Explore the cosmos with our Liquid Galaxy integration. "
                "Navigate through space, view celestial objects, and get real-time "
                "space weather data all in one place.",
                style: TextStyle(
                  color: Colors.white,
                  height: 1.5,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
              SizedBox(height: isSmallScreen ? 16 : 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeatureIcon(
                    LucideIcons.globe,
                    "Planetary Data",
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildFeatureIcon(
                    LucideIcons.satellite,
                    "Live Tracking",
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildFeatureIcon(
                    LucideIcons.database,
                    "3D Models",
                    isSmallScreen: isSmallScreen,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label, {required bool isSmallScreen}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent.withOpacity(0.2),
                Colors.blueAccent.withOpacity(0.2)
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.purpleAccent,
            size: isSmallScreen ? 18 : 20,
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade900.withOpacity(0.8),
            Colors.black,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Stars
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
          // Nebula effects
          Positioned(
            right: -screenWidth * 0.25,
            top: -screenHeight * 0.1,
            child: Container(
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
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
          Positioned(
            left: -screenWidth * 0.2,
            bottom: -screenHeight * 0.1,
            child: Container(
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.08),
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
}