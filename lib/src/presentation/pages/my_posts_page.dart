import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/src/data/models/post_model.dart';
import 'package:flutter_app/src/presentation/manager/remote_comment_bloc/remote_comment_bloc.dart';
import 'package:flutter_app/src/presentation/manager/remote_post_bloc/remote_post_bloc.dart';
import 'package:flutter_app/src/presentation/pages/my_comments_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector.dart';

class MyPostsPage extends StatefulWidget {
  final String title;

  MyPostsPage(this.title);

  @override
  _MyPostsPageState createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => injector<RemotePostBloc>()..add(GetRemotePosts()),
          ),
        ],
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(),
        ));
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: Text(widget.title),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemotePostBloc, RemotePostState>(
      builder: (context, state) {
        if (state is RemotePostLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RemotePostLoadingDone) {
          return _showListOfPosts(context, state.posts!);
        } else if (state is RemotePostError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text("Error ${state.error}", textAlign: TextAlign.center),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemotePostBloc>(context)
                      .add(GetRemotePosts());
                },
                child: Text("Try again"),
              )
            ])),
          );
        }
        return Container();
      },
    );
  }

  Widget _showListOfPosts(BuildContext context, List<PostModel> posts) {
    return RefreshIndicator(
        child: ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Icon(
                    Icons.post_add,
                    color: Colors.blue
                  ),
                  title: Text(posts[index].title),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCommentsPage(
                                posts[index].postId, posts[index].title)));
                  },
                ),
              );
            }),
        onRefresh: () => _onRefresh(context));
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<RemotePostBloc>(context).add(GetRemotePosts());
  }
}
