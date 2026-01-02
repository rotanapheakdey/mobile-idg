import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final pic1 = "https://i.pinimg.com/1200x/70/c6/e6/70c6e607607d555af4ad48dfc076b683.jpg";
  final logo = "https://i.pinimg.com/736x/e1/80/3e/e1803e4de2a4f4433453da967147452e.jpg";
  final bgImage = "https://i.pinimg.com/736x/7a/41/3d/7a413dc9cc3524106a4113c0244461eb.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1A1A1A), // CHANGED: Deep Onyx Background
      appBar: _buildAppBar(context),
      
      // 2. Here you can swap methods to test different looks!
      body: _buildImageBackground(child: _buildShadowedImage()), 
      
      drawer: _buildDrawer(context),
      endDrawer: _buildEndDrawer(),
      floatingActionButton: _buildFloating(),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  // --- Main Body Option: Gradient Background + Shadowed Image ---
  Widget _buildGradientBody() {
    return _buildGradientBackground(
      child: _buildShadowedImage()
    );
  }

  Widget _buildImageBackground({required Widget child}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(bgImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xFF000000).withOpacity(0.7), // CHANGED: Darker overlay
            BlendMode.darken, 
          ),
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _buildGradientBackground({Widget? child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // CHANGED: Dark Gradient (Onyx to Charcoal)
          colors: [
            const Color(0xFF1A1A1A), 
            const Color(0xFF333333)
          ], 
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _buildShadowedImage() {
    return Container(
      width: 250,
      height: 450,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(pic1),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8), // CHANGED: Darker shadow
            offset: const Offset(0, 0),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        icon: CachedNetworkImage(
          imageUrl: logo,
          width: 30, 
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
      ),
      title: Text("កម្មវិធី",
          style: GoogleFonts.moulpali(
            textStyle: const TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 20,
            ),
          )),
      backgroundColor: const Color(0xFF1A1A1A), 
      foregroundColor: Colors.white,
      
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A1A), Color(0xFF2C2C2C)],
          ),
        ),
      ),
      
      actions: [
        IconButton(
          onPressed: () => _showSnackBar(context, "hello"),
          icon: const Icon(Icons.share, color: Color(0xFFA0A0A0)), // Silver Icon
        ),
        IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.facebook, color: Color(0xFFA0A0A0)) // Silver Icon
        ),
        IconButton(
          onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
          icon: const Icon(Icons.more_vert, color: Color(0xFFA0A0A0)), // Silver Icon
        ),
      ],
    );
  }

  // --- Other Widgets ---
  
  _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF333333), // CHANGED: Dark Snack bar
        content: Text(text, style: const TextStyle(color: Colors.white)),
        action: SnackBarAction(
          label: 'DONE',
          textColor: const Color(0xFF6A6E75),
          onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A), // CHANGED: Dark Drawer
      width: 250,
      child: ListView(
        children: [
          DrawerHeader(child: CachedNetworkImage(imageUrl: logo)),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFFA0A0A0)),
            title: const Text("Home", style: TextStyle(color: Color(0xFFE0E0E0))),
            trailing: const Icon(Icons.navigate_next, color: Color(0xFFA0A0A0)),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.developer_board, color: Color(0xFFA0A0A0)),
            title: const Text("Developers", style: TextStyle(color: Color(0xFFE0E0E0))),
            trailing: const Icon(Icons.navigate_next, color: Color(0xFFA0A0A0)),
            onTap: () => Navigator.of(context).pop(),
          ),
          const Divider(color: Color(0xFF333333)),
        ],
      ),
    );
  }

  Widget _buildEndDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: CachedNetworkImage(
        imageUrl: pic1, 
        fit: BoxFit.cover,
        placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color(0xFFE0E0E0), // CHANGED: White/Silver accent
      foregroundColor: const Color(0xFF1A1A1A), // Dark Icon
      onPressed: () {},
      child: const Icon(Icons.search),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: const Color(0xFF1A1A1A), // CHANGED: Onyx
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home, color: Color(0xFFA0A0A0))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Color(0xFFA0A0A0))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person, color: Color(0xFFA0A0A0))),
          IconButton(
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            icon: const Icon(Icons.more_horiz, color: Color(0xFFA0A0A0)),
          ),
        ],
      ),
    );
  }
}