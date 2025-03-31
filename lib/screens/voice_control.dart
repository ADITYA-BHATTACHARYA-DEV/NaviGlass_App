import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class VoiceControlScreen extends StatefulWidget {
  @override
  _VoiceControlScreenState createState() => _VoiceControlScreenState();
}

class _VoiceControlScreenState extends State<VoiceControlScreen> {
  final List<String> _chatMessages = [
    "Welcome to Voice Navigation! 🚀",
    "Try saying: 'Take me to Mars' 🪐",
    "Or 'Show me the ISS location' 🛰",
  ];

  void _sendMessage(String message) {
    setState(() {
      _chatMessages.add(message);
      _chatMessages.add("Processing your request... 🔄");
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _chatMessages.removeLast();
        _chatMessages.add("Command executed! ✅");
      });
    });
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Voice Control Settings", style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(LucideIcons.volume2, color: Colors.purpleAccent),
                title: Text("Sensitivity", style: TextStyle(color: Colors.white)),
                trailing: DropdownButton(
                  dropdownColor: Colors.black,
                  value: "Medium",
                  items: ["Low", "Medium", "High"]
                      .map((e) => DropdownMenuItem(child: Text(e, style: TextStyle(color: Colors.white)), value: e))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                leading: Icon(LucideIcons.mic, color: Colors.purpleAccent),
                title: Text("Enable Voice Command", style: TextStyle(color: Colors.white)),
                trailing: Switch(value: true, onChanged: (bool value) {}),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Voice Control"),
        backgroundColor: Colors.purpleAccent.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.settings, color: Colors.white),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                bool isUser = index % 2 != 0;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.purpleAccent.withOpacity(0.7) : Colors.blueGrey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      _chatMessages[index],
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.purpleAccent),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Say a command...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _sendMessage("User Command"),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Colors.purpleAccent, Colors.blueAccent]),
                      boxShadow: [BoxShadow(color: Colors.purpleAccent, blurRadius: 10)],
                    ),
                    child: Icon(LucideIcons.mic, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}