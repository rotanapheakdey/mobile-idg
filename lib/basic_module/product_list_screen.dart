import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // 1. Fetch Data from the Real API
  Future<List<Product>> fetchProductList() async {
    String url = "https://fakestoreapi.com/products";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Product.fromMap(item)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "FakeStore Bento",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProductList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildBentoGrid(snapshot.data!);
            } else {
              return const Center(child: Text("No Data"));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // 2. The Bento Grid Layout
  Widget _buildBentoGrid(List<Product> items) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: StaggeredGrid.count(
        crossAxisCount: 2, // Total columns
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: items.asMap().entries.map((entry) {
          int index = entry.key;
          Product product = entry.value;

          // --- Bento Logic ---
          // Make the 1st item BIG (Hero)
          // Make every 4th item TALL (Vertical)
          int crossAxisCount = 1;
          num mainAxisCount = 1;

          if (index == 0) {
            crossAxisCount = 2; // Full width
            mainAxisCount = 1.2;
          } else if ((index % 4) == 0) { 
            mainAxisCount = 1.6; // Tall vertical tile
          }

          return StaggeredGridTile.count(
            crossAxisCellCount: crossAxisCount,
            mainAxisCellCount: mainAxisCount,
            child: _buildProductTile(product, isDark: index == 0),
          );
        }).toList(),
      ),
    );
  }

  // 3. The Individual Tile Design
  Widget _buildProductTile(Product product, {bool isDark = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Image
          Padding(
            padding: const EdgeInsets.all(20.0), // Padding so image fits nicely
            child: Center(
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Gradient Overlay & Text
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}