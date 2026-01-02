import 'package:flutter/material.dart';
// Import your screens
import 'food_screen.dart';
import 'first_screen.dart'; // Assuming this corresponds to the second tab
import 'login_screen.dart'; // Using this instead of ThirdScreen since you have it
import 'layout_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Variable to track active tab
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- 1. The Body (Matches the screenshot) ---
  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        const FoodScreen(),     // Tab 1: Home
        const LayoutScreen(),   // Tab 2: Search (I put Layout here)
        const LoginScreen(),    // Tab 3: Profile/Person (I put Login here)
        const FirstScreen(),    // Tab 4: Menu (I put FirstScreen here)
      ],
    );
  }

  // --- 2. The Bottom Nav Bar (Matches the screenshot) ---
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed, // Keeps all 4 icons visible
      selectedItemColor: Colors.pink,      // Matches your teacher's color
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: "Menu",
        ),
      ],
    );
  }
}