import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// MAKE SURE THESE PATHS ARE CORRECT FOR YOUR PROJECT
import '../../basic_module/logics/theme_logic.dart'; 
import 'food_screen.dart';
import 'first_screen.dart';
import 'login_screen.dart';
import 'layout_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 1. Define a scaffold key to control drawers/snackbars if needed later
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign key to scaffold
      
      
      
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- THE BODY STAYS THE SAME ---
  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: const [
        FoodScreen(),
        LayoutScreen(),
        LoginScreen(),
        FirstScreen(),
      ],
    );
  }

  // --- 2. UPDATED BOTTOM NAV BAR ---
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        // Check if the "Menu" tab (index 3) was tapped
        if (index == 3) {
          // Instead of changing the tab or opening a drawer, show the sheet
          _showThemeBottomSheet(context);
        } else {
          // For other tabs, just change the index normally
          setState(() {
            _currentIndex = index;
          });
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        // This label matches your screenshot's intent
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Theme"),
      ],
    );
  }

  // --- 3. NEW FUNCTION TO BUILD THE BOTTOM SHEET ---
  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // This gives the top corners the rounded look
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // We watch ThemeLogic here to know which checkmark to show
        final themeLogic = context.watch<ThemeLogic>();
        final currentMode = themeLogic.mode;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content height
            children: [
              // The small gray handle bar at the top
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Change App Theme",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Divider(height: 1, color: Colors.grey[300]),
              
              // OPTION 1: SYSTEM
              ListTile(
                leading: const Icon(Icons.phone_android),
                title: const Text("Change To System"),
                // Show checkmark if this is the active mode
                trailing: currentMode == ThemeMode.system
                    ? const Icon(Icons.check_circle, color: Colors.pink)
                    : null,
                onTap: () {
                  // Use read() to perform the action
                  context.read<ThemeLogic>().changeToSystem();
                  Navigator.pop(context); // Close the sheet
                },
              ),
              
              // OPTION 2: DARK
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text("Change To Dark"),
                trailing: currentMode == ThemeMode.dark
                    ? const Icon(Icons.check_circle, color: Colors.pink)
                    : null,
                onTap: () {
                  context.read<ThemeLogic>().changeToDark();
                  Navigator.pop(context);
                },
              ),

              // OPTION 3: LIGHT
              ListTile(
                leading: const Icon(Icons.light_mode_outlined),
                title: const Text("Change To Light"),
                trailing: currentMode == ThemeMode.light
                    ? const Icon(Icons.check_circle, color: Colors.pink)
                    : null,
                onTap: () {
                  context.read<ThemeLogic>().changeToLight();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10), // Bottom padding
            ],
          ),
        );
      },
    );
  }
}