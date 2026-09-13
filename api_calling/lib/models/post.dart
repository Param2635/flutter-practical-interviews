class PostResponse {
  final List<Post> posts;
  final int total;
  final int skip;
  final int limit;

  PostResponse({
    required this.posts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json){
    return PostResponse(
      posts: (json['posts'] as List).map((posts) => Post.fromJson(posts)).toList(),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}

class Post {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final Reaction reaction;
  final int views;
  final int userId;

  Post({required this.id, required this.title, required this.body, required this.tags, required this.reaction, required this.views, required this.userId});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post (
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      tags: List<String>.from(json['tags']),
      reaction: json['reactions'] != null ? Reaction.fromJson(json['reactions']) : Reaction.empty(),
      views: json['views'] ?? 0,
      userId: json['userId'] ?? 0,
    );
  }
}

class Reaction {
  final int likes;
  final int dislikes;

  Reaction({
    required this.likes,
    required this.dislikes,
  });

  factory Reaction.fromJson(Map<String, dynamic> json){
    return Reaction(
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
    );
  }

  factory Reaction.empty() {
    return Reaction(likes: 0, dislikes: 0,);
  }
}
