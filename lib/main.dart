import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'basic_module/logics/theme_logic.dart'; // Adjust path if needed
import 'basic_module/basic_splash_screen.dart'; // Adjust path if needed

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeLogic()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeLogic = context.watch<ThemeLogic>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      // 3. Apply the theme from logic
      themeMode: themeLogic.mode, 
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      
      home: const BasicSplashScreen(),
    );
  }
}