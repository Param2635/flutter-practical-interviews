import 'package:auth/models/post.dart';
import 'package:auth/services/api_service.dart';
import 'package:auth/bloc/posts/post_event.dart';
import 'package:auth/bloc/posts/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState>{
  final ApiService apiService;
  final List<Post> _posts =[];
  bool _isloading = false;

  PostBloc(this.apiService) : super(PostInitial()) {
    on<FetchPosts>(_fetchPosts);
  }

  Future<void> _fetchPosts(
    FetchPosts event,
    Emitter<PostState> emit,
  ) async {
    if (_isloading) return;

    _isloading = true;

    //1st Request
    if(event.skip == 0){
      emit(PostLoading());
      _posts.clear;
    }

    try{
      final response = await apiService.fetchPost(limit: event.limit, skip: event.skip);

      _posts.addAll(response.posts);

      final hasMore = _posts.length < response.total;

      emit(
          PostSuccess(
            List.from(_posts),
            hasMore: hasMore,
          )
      );
    } catch(e) {
      emit(PostError(e.toString()));
    } finally {
      _isloading = false;
    }
  }
}