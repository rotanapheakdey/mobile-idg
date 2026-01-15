import 'package:flutter/material.dart';
// import 'first_screen.dart';
// import 'second_screen.dart';
// import 'third_screen.dart';
// import 'login_screen.dart';
// import  'layout_screen.dart';
// import 'food_screen.dart';
// import 'main_screen.dart';
import 'product_list_screen.dart';


// 
// 1. ADDED: The main function to start the app
void main() {
  runApp(const BasicApp());
}

class BasicApp extends StatelessWidget{
  const BasicApp({super.key});

  @override
  Widget build (BuildContext context) {
    return MaterialApp( // Added const for performance
    debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}

// 2. ADDED: The definition of FirstScreen
