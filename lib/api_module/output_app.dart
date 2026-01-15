import 'post_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasicApp());
}

class BasicApp extends StatelessWidget{
  const BasicApp({super.key});

  @override
  Widget build (BuildContext context) {
    return MaterialApp( // Added const for performance
    debugShowCheckedModeBanner: false,
      home: PostScreen(),
    );
  }
}