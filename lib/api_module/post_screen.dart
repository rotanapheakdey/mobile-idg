import 'package:flutter/material.dart';
import 'models/post_model.dart';
import 'services/post_service.dart';
import 'widgets/my_loading.dart'; // 1. Import your new widget

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostService _postService = PostService();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Grid")),
      floatingActionButton: _buildFloating(),
      body: FutureBuilder<List<Post>>(
        future: _postService.getApi(),
        builder: (context, snapshot) {
          
          // 2. Use MyLoading widget instead of CircularProgressIndicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoading(); 
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.hasData) {
            return GridView.builder(
              controller: _scrollController, // <--- ADD THIS LINE HERE
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10,  
                childAspectRatio: 1.0, 
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var post = snapshot.data![index];
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${post.id}. ${post.title}",
                          maxLines: 2, 
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            post.body,
                            overflow: TextOverflow.fade, 
                            style: TextStyle(color: Colors.grey[700], fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No Data"));
        },
      ),
    );
  }

  Widget _buildFloating() {
  return FloatingActionButton(
    backgroundColor: Colors.deepPurple,
    child: const Icon(Icons.arrow_upward, color: Colors.white),
    onPressed: () {
      _scrollController.animateTo(
        0, 
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut, 
      );
    },
  );
}
}