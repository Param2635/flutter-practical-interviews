import 'package:auth/bloc/posts/post_bloc.dart';
import 'package:auth/bloc/posts/post_event.dart';
import 'package:auth/bloc/posts/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>{
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll(){
    if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200){
      final bloc = context.read<PostBloc>();
      final state = bloc.state;

      if(state is PostSuccess && state.hasMore) {
        bloc.add(
          FetchPosts(
            limit: 10,
            skip: state.posts.length,
          )
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('DummyJson api data', style: TextStyle(color: Colors.white),),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state){
          if (state is PostLoading){
            return const Center (
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostError){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<PostBloc>()
                            .add(FetchPosts());
                      },
                      child: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          if(state is PostSuccess){
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];

                return ListTile(
                  leading: CircleAvatar(child: Text(post.id.toString())),
                  title: Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(post.body),
                );
              },
            );
          }
          return const SizedBox.shrink();
        }
      )
    );
  }
}