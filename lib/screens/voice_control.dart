import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class VoiceControlScreen extends StatefulWidget {
  @override
  _VoiceControlScreenState createState() => _VoiceControlScreenState();
}

class _VoiceControlScreenState extends State<VoiceControlScreen> {
  final List<Map<String, dynamic>> _chatMessages = [
    {"text": "Welcome to Space Voice Control 🚀", "isUser": false, "time": "Just now"},
    {"text": "Try saying: 'Navigate to Jupiter' 🪐", "isUser": false, "time": "Just now"},
    {"text": "Or 'Show me the Andromeda galaxy' 🌌", "isUser": false, "time": "Just now"},
    {"text": "Find nearby exoplanets", "isUser": true, "time": "2 min ago"},
    {"text": "Found 3 potentially habitable exoplanets within 100 light years", "isUser": false, "time": "2 min ago"},
  ];

  final List<String> _recentQueries = [
    "Current ISS position",
    "Solar flare activity",
    "Next lunar eclipse",
    "Mars weather report",
    "Nearest black hole"
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
              colors: [Colors.deepPurple.shade900, Colors.black87],
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
                        color: Colors.purpleAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Cosmic Control Panel", 
                      style: TextStyle(
                        fontSize: 22, 
                        color: Colors.white, 
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2
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
                        activeColor: Colors.purpleAccent,
                        inactiveColor: Colors.blueGrey,
                      ),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.mic,
                      title: "Voice Activation",
                      trailing: Switch(
                        value: true,
                        onChanged: (bool value) {},
                        activeColor: Colors.purpleAccent,
                      ),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.languages,
                      title: "Cosmic Language",
                      trailing: DropdownButton<String>(
                        dropdownColor: Colors.deepPurple.shade900,
                        value: "Universal Basic",
                        items: ["Universal Basic", "Galactic Standard", "Quantum Syntax"]
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(e, style: TextStyle(color: Colors.white)),
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
                      title: "Nebula Colors",
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildColorOption(Colors.deepPurple),
                          SizedBox(width: 10),
                          _buildColorOption(Colors.indigo),
                          SizedBox(width: 10),
                          _buildColorOption(Colors.blueAccent),
                        ],
                      ),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.star,
                      title: "Stellar Animation",
                      trailing: Switch(
                        value: true,
                        onChanged: (bool value) {},
                        activeColor: Colors.purpleAccent,
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  _buildSettingsSection("Advanced", [
                    _buildSettingItem(
                      icon: LucideIcons.satellite,
                      title: "Quantum Connection",
                      trailing: Text("Optimal", style: TextStyle(color: Colors.greenAccent)),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.cpu,
                      title: "AI Processing Power",
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
            color: Colors.purpleAccent.withOpacity(0.7),
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
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
          Icon(icon, color: Colors.purpleAccent, size: 20),
          SizedBox(width: 15),
          Expanded(child: Text(title, style: TextStyle(color: Colors.white, fontSize: 10))),
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
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildSpaceBackground() {
    return Stack(
      children: [
        // Deep space gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade900,
                Colors.black,
              ],
            ),
          ),
        ),
        // Stars
        for (int i = 0; i < 50; i++)
          Positioned(
            left: Random().nextDouble() * MediaQuery.of(context).size.width,
            top: Random().nextDouble() * MediaQuery.of(context).size.height,
            child: Container(
              width: Random().nextDouble() * 2 + 1,
              height: Random().nextDouble() * 2 + 1,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(Random().nextDouble() * 0.5 + 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        // Nebula effect
        Positioned(
          right: -100,
          top: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.purple.withOpacity(0.1),
                  Colors.transparent,
                ],
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
                colors: [
                  Colors.blueAccent.withOpacity(0.1),
                  Colors.transparent,
                ],
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildSpaceBackground(),
          Column(
            children: [
              AppBar(
                title: Text(
                  "Cosmic Voice Control",
                  style: TextStyle(
                    color: Colors.white,
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
                    icon: Icon(LucideIcons.settings, color: Colors.purpleAccent),
                    onPressed: _openSettings,
                  ),
                ],
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [Colors.purpleAccent, Colors.blueAccent],
                            ),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white70,
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
                            // Conversation Tab
                            ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: _chatMessages.length,
                              itemBuilder: (context, index) {
                                final message = _chatMessages[index];
                                return AnimatedOpacity(
                                  opacity: 1,
                                  duration: Duration(milliseconds: 300),
                                  child: Align(
                                    alignment: message["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                                    child: Container(
                                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                                      padding: EdgeInsets.all(12),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: message["isUser"]
                                              ? [Colors.purple.shade800, Colors.indigo.shade800]
                                              : [Colors.blueGrey.shade800, Colors.blueGrey.shade900],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: message["isUser"] ? Radius.circular(15) : Radius.zero,
                                          bottomRight: message["isUser"] ? Radius.zero : Radius.circular(15),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purpleAccent.withOpacity(message["isUser"] ? 0.3 : 0.1),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            message["text"],
                                            style: TextStyle(color: Colors.white, fontSize: 16),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            message["time"],
                                            style: TextStyle(color: Colors.white70, fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Recent Queries Tab
                            ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: _recentQueries.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  color: Colors.black.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: Colors.purpleAccent.withOpacity(0.3)),
                                  ),
                                  child: ListTile(
                                    leading: Icon(LucideIcons.search, color: Colors.purpleAccent),
                                    title: Text(
                                      _recentQueries[index],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Icon(LucideIcons.chevronRight, color: Colors.white54),
                                    onTap: () => _sendMessage(_recentQueries[index]),
                                  ),
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
              // Input Area
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple.shade900.withOpacity(0.5), Colors.blue.shade900.withOpacity(0.5)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.purpleAccent.withOpacity(0.5)),
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Speak your cosmic command...",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            suffixIcon: Icon(LucideIcons.send, color: Colors.purpleAccent),
                          ),
                          onSubmitted: _sendMessage,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purpleAccent.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(LucideIcons.mic, color: Colors.white, size: 30),
                        onPressed: () => _sendMessage("Voice command"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}