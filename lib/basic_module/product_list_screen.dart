import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // 1. Fetch Data
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
      appBar: AppBar(
        title: const Text("My Shop"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProductList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildSimpleList(snapshot.data!);
            } else {
              return const Center(child: Text("No Data"));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // 2. The Simple List Design
  Widget _buildSimpleList(List<Product> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final product = items[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            // Image on the left
            leading: Image.network(
              product.image, 
              width: 50, 
              height: 50,
              fit: BoxFit.contain,
            ),
            // Title in the middle
            title: Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Price at the bottom
            subtitle: Text(
              "\$${product.price}",
              style: const TextStyle(
                color: Colors.green, 
                fontWeight: FontWeight.bold
              ),
            ),
            // Arrow icon on the right
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}