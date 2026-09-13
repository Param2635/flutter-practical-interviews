import '../../models/post.dart';

abstract class PostState {}

class PostInitial extends PostState{}

class PostLoading extends PostState{}

class PostSuccess extends PostState{
  final List<Post> posts;
  final bool hasMore;

  PostSuccess(
      this.posts, {
        this.hasMore = true
  });
}

class PostError extends PostState{
  final String message;

  PostError(this.message);
}