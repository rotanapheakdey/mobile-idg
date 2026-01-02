import 'package:flutter/material.dart';

// Class 1: The Widget (Immutable/Constant configuration)
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _MyWidgetState();
}

// Class 2: The State (Mutable/Changing data)
class _MyWidgetState extends State<SecondScreen> {
  int _number = 12; // Start at a visible font size
  String text = "Hello World"; // Variable was missing

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        actions: [ // Fixed: was 'action'
          IconButton(
            onPressed: () {
              setState(() {
                if (_number > 0) _number--; // Prevent crash (size < 0)
              });
              debugPrint("_number: $_number");
            },
            icon: const Icon(Icons.remove),
          ), // Fixed: Missing comma
          IconButton(
            onPressed: () {
              setState(() {
                _number++;
              });
              debugPrint("_number: $_number");
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: _number.toDouble(),
          ),
        ),
      ),
    );
  }
}