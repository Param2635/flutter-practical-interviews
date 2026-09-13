import 'package:flutter/cupertino.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent{
  final int limit;
  final int skip;

  FetchPosts({
    this.limit = 10,
    this.skip = 0,
  });
}