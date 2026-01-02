import 'package:carousel_slider/carousel_slider.dart'; // 1. Import this
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
              style: GoogleFonts.metal(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 41, 41, 41),
                  fontSize: 20,
                ),
              )),
          backgroundColor: const Color(0xFFFAF9F6),
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
                  _buildGridView(foodList1 + foodList2+westernFoods), 
                  _buildGridView(westernFoods), 
                  _buildGridView(foodList2), 
                ],
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: _buildFloatingBottomBar(),
      ),
    );
  }

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
                  child: Image.network(item.image, fit: BoxFit.cover, width: double.infinity),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.metal(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "\$${item.price.toStringAsFixed(2)}",
                      style: GoogleFonts.metalMania(color: Colors.green, fontSize: 14),
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
  Widget _buildFloatingBottomBar() {
  return Container(
    // 1. Makes it look "Floating"
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20), 
    child: Container(
      height: 65, // Taller to fit the floating look
      decoration: BoxDecoration(
        color:  const Color(0xFFF0FFFF), // Dark background (from your palette)
        borderRadius: BorderRadius.circular(30), // Makes it pill-shaped/rounded
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Spaces icons equally
        children: [
          _buildIcon(0, Icons.home_rounded, "Home"),
          _buildIcon(1, Icons.search_rounded, "Search"),
          _buildIcon(2, Icons.shopping_bag_outlined, "Cart"),
          _buildIcon(3, Icons.person_outline, "Profile"),
        ],
      ),
    ),
  );
}

Widget _buildIcon(int index, IconData icon, String tooltip) {
  // Checks if this specific icon is selected
  final bool isSelected = _selectedIndex == index;

  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedIndex = index;
      });
    },
    // AnimatedContainer makes the color change smooth!
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: isSelected 
          ? BoxDecoration(
              color: const Color.fromARGB(255, 48, 48, 48), // Active light color
              shape: BoxShape.circle,
            )
          : null, // No background if not selected
      child: Icon(
        icon,
        // Change color based on selection: Dark if selected (to contrast with circle), Grey if not
        color: isSelected ? const Color.fromARGB(255, 238, 238, 238) : const Color(0xFF28282B),
        size: 26,
      ),
    ),
  );
}
}