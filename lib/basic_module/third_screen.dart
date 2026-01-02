import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    // FIXED: Return a Scaffold, not a Placeholder
    return Scaffold(
      appBar: AppBar(title: const Text("Bar Chart")),
      // FIXED: Actually call your build method here
      body: _buildBody(), 
    );
  }

  Widget _buildBody() {
    // FIXED: Removed the infinite loop. Now it calls the next function.
    return _buildRow(); 
  }

  // I changed this from Column to Row so it fits on the screen!
  Widget _buildRow() {
    return Center(
      child: Row( // Changed Column to Row
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end, // Aligns bars to the bottom
        children: [
          Container(width: 50, height: 250, color: Colors.blue),
          const SizedBox(width: 8), // Changed height to width for spacing
          Container(width: 50, height: 290, color: Colors.pink),
          const SizedBox(width: 8),
          Container(width: 50, height: 280, color: Colors.yellow),
          const SizedBox(width: 8),
          Container(width: 50, height: 240, color: Colors.orange),
          const SizedBox(width: 8),
          Container(width: 50, height: 290, color: Colors.lime),
        ],
      ),
    );
  }
}