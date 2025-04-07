import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class VoiceControlScreen extends StatefulWidget {
  @override
  _VoiceControlScreenState createState() => _VoiceControlScreenState();
}

class _VoiceControlScreenState extends State<VoiceControlScreen> {
  final Color _primaryColor = Color(0xFF6A11CB);
  final Color _secondaryColor = Color(0xFF2575FC);
  final Color _accentColor = Color(0xFF00F2FE);
  final Color _textColor = Colors.white;
  final Color _bgColor = Color(0xFF0F0F1B);

  final List<Map<String, dynamic>> _chatMessages = [
    {"text": "Welcome to Voice Control 🚀", "isUser": false, "time": "Just now"},
    {"text": "Try saying: 'Navigate to Jupiter' 🪐", "isUser": false, "time": "Just now"},
    {"text": "Or 'Tell me about the Andromeda galaxy' 🌌", "isUser": false, "time": "Just now"},
    {"text": "Find nearby cafes", "isUser": true, "time": "2 min ago"},
    {"text": "Found 3 potentially good restaurants within 100 metres", "isUser": false, "time": "2 min ago"},
  ];

  final List<String> _recentQueries = [
    "Current humidity position",
    "Weather activity",
    "Next lunar eclipse",
    "Today's weather report",
    "Nearest playzone"
  ];

  void _sendMessage(String message) {
    setState(() {
      _chatMessages.add({"text": message, "isUser": true, "time": "Just now"});
      _chatMessages.add({"text": "Processing your cosmic request... 🌠", "isUser": false, "time": "Just now"});
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _chatMessages.removeLast();
        _chatMessages.add({"text": "Command executed across the cosmos! ✅", "isUser": false, "time": "Just now"});
      });
    });
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_primaryColor.withOpacity(0.9), _bgColor],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: _accentColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Voice Control Panel",
                      style: TextStyle(
                        fontSize: 22,
                        color: _textColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSettingsSection("Voice Configuration", [
                    _buildSettingItem(
                      icon: LucideIcons.volume2,
                      title: "Voice Sensitivity",
                      trailing: Slider(
                        value: 0.7,
                        onChanged: (value) {},
                        activeColor: _accentColor,
                        inactiveColor: Colors.blueGrey,
                      ),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.mic,
                      title: "Voice Activation",
                      trailing: Switch(
                        value: true,
                        onChanged: (bool value) {},
                        activeColor: _accentColor,
                      ),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.languages,
                      title: "Language",
                      trailing: DropdownButton<String>(
                        dropdownColor: _bgColor,
                        value: "Universal Basic",
                        items: ["Universal Basic", "Basic Standard", "Quantum Syntax"]
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(e, style: TextStyle(color: _textColor)),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  _buildSettingsSection("Visual Theme", [
                    _buildSettingItem(
                      icon: LucideIcons.palette,
                      title: "Theme Colors",
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildColorOption(_primaryColor),
                          SizedBox(width: 10),
                          _buildColorOption(_secondaryColor),
                          SizedBox(width: 10),
                          _buildColorOption(_accentColor),
                        ],
                      ),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.star,
                      title: "Animations",
                      trailing: Switch(
                        value: true,
                        onChanged: (bool value) {},
                        activeColor: _accentColor,
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  _buildSettingsSection("Advanced", [
                    _buildSettingItem(
                      icon: LucideIcons.satellite,
                      title: "Connection",
                      trailing: Text("Optimal", style: TextStyle(color: Colors.greenAccent)),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.cpu,
                      title: "AI Processing",
                      trailing: Text("78%", style: TextStyle(color: Colors.orangeAccent)),
                    ),
                  ]),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            color:    _textColor,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _bgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _accentColor.withOpacity(0.2)),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingItem({required IconData icon, required String title, required Widget trailing}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: _accentColor, size: 20),
          SizedBox(width: 15),
          Expanded(child: Text(title, style: TextStyle(color: _textColor, fontSize: 14))),
          trailing,
        ],
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: _textColor.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildSpaceBackground() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_bgColor, _primaryColor.withOpacity(0.3)],
            ),
          ),
        ),
        for (int i = 0; i < 50; i++)
          Positioned(
            left: Random().nextDouble() * MediaQuery.of(context).size.width,
            top: Random().nextDouble() * MediaQuery.of(context).size.height,
            child: Container(
              width: Random().nextDouble() * 2 + 1,
              height: Random().nextDouble() * 2 + 1,
              decoration: BoxDecoration(
                color: _textColor.withOpacity(Random().nextDouble() * 0.5 + 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        Positioned(
          right: -100,
          top: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [_primaryColor.withOpacity(0.2), Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          left: -50,
          bottom: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [_secondaryColor.withOpacity(0.2), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          _buildSpaceBackground(),
          Column(
            children: [
              AppBar(
                title: Text(
                  "VOICE CONTROL",
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(LucideIcons.settings, color: _accentColor),
                    onPressed: _openSettings,
                  ),
                ],
              ),
              Expanded(
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: _bgColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _accentColor.withOpacity(0.2)),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [_primaryColor, _secondaryColor],
                            ),
                          ),
                          labelColor: _textColor,
                          unselectedLabelColor: _textColor.withOpacity(0.7),
                          tabs: [
                            Tab(text: "Conversation"),
                            Tab(text: "Recent Queries"),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.all(5),
                              itemCount: _chatMessages.length,
                              itemBuilder: (context, index) {
                                final message = _chatMessages[index];
                                return Align(
                                  alignment: message["isUser"]
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: message["isUser"]
                                            ? [_primaryColor, _secondaryColor]
                                            : [_bgColor, Colors.blueGrey.shade900],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: message["isUser"]
                                            ? Radius.circular(15)
                                            : Radius.zero,
                                        bottomRight: message["isUser"]
                                            ? Radius.zero
                                            : Radius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      message["text"],
                                      style: TextStyle(
                                          color: _textColor, fontSize: 14),
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: _recentQueries.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    _recentQueries[index],
                                    style: TextStyle(color: _textColor),
                                  ),
                                  leading: Icon(LucideIcons.clock, color: _accentColor),
                                  onTap: () => _sendMessage(_recentQueries[index]),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
