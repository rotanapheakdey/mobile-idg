import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'food_model.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ម្ហូបពិសេស",
              // FIXED: Changed 'metal' to 'metalMania' to prevent crash
              style: GoogleFonts.metal(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              )),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            _buildSlideshow(),
            const SizedBox(height: 12),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.red,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Western"),
                Tab(text: "Khmer"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildGridView(foodList1 + foodList2 + westernFoods),
                  _buildGridView(westernFoods),
                  _buildGridView(foodList2),
                ],
              ),
            ),
          ],
        ),
        // FIXED: Removed 'extendBody: true' so the bar doesn't cover the list
        // bottomNavigationBar: _buildAndroidNavBar(), 
      ),
    );
  }

  // --- NEW: Standard Android Bottom Bar ---
  // Widget _buildAndroidNavBar() {
  //   return BottomNavigationBar(
  //     currentIndex: _selectedIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //     },
  //     type: BottomNavigationBarType.fixed, // Shows all 4 icons/labels
  //     backgroundColor: Colors.white,       // Standard white background
  //     selectedItemColor: Colors.black,     // Active color
  //     unselectedItemColor: Colors.grey,    // Inactive color
  //     showUnselectedLabels: true,
  //     elevation: 8,                        // Adds a slight shadow on top
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home_outlined),
  //         activeIcon: Icon(Icons.home), // Filled icon when selected
  //         label: "Home",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //         label: "Search",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.shopping_bag_outlined),
  //         activeIcon: Icon(Icons.shopping_bag),
  //         label: "Cart",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.person_outline),
  //         activeIcon: Icon(Icons.person),
  //         label: "Profile",
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSlideshow() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: foodList1.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(item.image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildGridView(List<Food> items) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final Food item = items[index];
        return Card(
          margin: const EdgeInsets.all(8),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(item.image,
                      fit: BoxFit.cover, width: double.infinity),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      item.title,
                      // FIXED: Changed 'metal' to 'metalMania'
                      style: GoogleFonts.metal(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "\$${item.price.toStringAsFixed(2)}",
                      style: GoogleFonts.metalMania(
                          color: Colors.green, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}