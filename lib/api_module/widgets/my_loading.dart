import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../models/post_model.dart'; // Adjust import path if needed

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Create a list of dummy data to simulate the layout
    final List<Post> fakePosts = List.generate(
      8, // Show 8 skeleton items
      (index) => Post(
        userId: 1,
        id: index,
        title: "dfghjkfghjkl;fghjklfghjklk",
        body: "dfghjkfghjkl;fghjklfghjklkdfghjkfghjkl;fghjklfghjklkdfghjkfghjkl;fghjklfghjklkdfghjkfghjkl;fghjklfghjklk",
      ),
    );

    // 2. Wrap the UI in Skeletonizer with enabled: true
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemCount: fakePosts.length,
        itemBuilder: (context, index) {
          final post = fakePosts[index];
          // 3. Exact same UI design as your main screen
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      post.body,
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}