import 'dart:convert';

import 'package:auth/models/post.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://dummyjson.com';

  Future<PostResponse> fetchPost({int limit = 10, int skip = 0,}) async{
    final response = await http.get(
      Uri.parse('$baseUrl/posts?limit=$limit&skip=$skip'),
      headers: {
        'Accept': 'application/json',
      },
    );

    print("STATUS CODE : ${response.statusCode}");
    print("RESPONSE : ${response.body}");

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);

      return PostResponse.fromJson(json);
    }else{
      throw Exception(
          'Failed to fetch posts: ${response.statusCode}',
      );
    }
  }
}