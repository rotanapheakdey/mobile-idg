import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'basic_app.dart';
import '../api_module/widgets/my_error.dart'; 
import 'logics/theme_logic.dart'; 

class BasicSplashScreen extends StatefulWidget {
  const BasicSplashScreen({super.key});

  @override
  State<BasicSplashScreen> createState() => _BasicSplashScreenState();
}

class _BasicSplashScreenState extends State<BasicSplashScreen> {
  Future? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  Future _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    return context.read<ThemeLogic>().readTheme();
  }

  @override
  Widget build(BuildContext context) {
    // REMOVED: return MaterialApp(...) 
    // We just return the logic directly. The MaterialApp in main.dart handles the rest.
    
    if (_futureData == null) {
      return _buildLogoLoading();
    }
    
    return FutureBuilder(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MyError(
            context,
            error: snapshot.error.toString(),
            onPressed: () {
              setState(() {
                _futureData = _loadData();
              });
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const BasicApp();
        } else {
          return _buildLogoLoading();
        }
      },
    );
  }

  Widget _buildLogoLoading() {
    return const Scaffold( // Scaffold is fine, just no MaterialApp!
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Loading..."),
            ),
          ],
        ),
      ),
    );
  }
}