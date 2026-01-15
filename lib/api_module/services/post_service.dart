import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostService {
  Future<List<Post>> getApi() async {
    final url = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        return compute(postFromJson, response.body);
      } else {
        throw Exception("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network Error: ${e.toString()}");
    }
  }
}
