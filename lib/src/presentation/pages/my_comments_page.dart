import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/src/data/models/comment_model.dart';
import 'package:flutter_app/src/presentation/manager/remote_comment_bloc/remote_comment_bloc.dart';
import 'package:flutter_app/src/presentation/widgets/item_commet_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector.dart';

class MyCommentsPage extends StatefulWidget {
  final int postId;
  final String postTitle;

  MyCommentsPage(this.postId, this.postTitle);

  @override
  _MyCommentsPageState createState() => _MyCommentsPageState();
}

class _MyCommentsPageState extends State<MyCommentsPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => injector<RemoteCommentBloc>()
              ..add(GetRemoteComments(widget.postId)),
          ),
        ],
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(),
        ));
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: Text("Comments"),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteCommentBloc, RemoteCommentState>(
      builder: (context, state) {
        if (state is RemoteCommentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RemoteCommentLoadingDone) {
          return _showListOfComments(context, state);
        } else if (state is RemoteCommentError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text("Error ${state.error}", textAlign: TextAlign.center),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteCommentBloc>(context)
                      .add(GetRemoteComments(widget.postId));
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

  Widget _showListOfComments(BuildContext context, RemoteCommentLoadingDone state) {
    return RefreshIndicator(
        child: ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: state.comments!.length,
            itemBuilder: (BuildContext context, int index) {
              CommentModel comment = state.comments![index];
              return ItemCommentWidget(comment.name, comment.email, comment.body);
              return ListTile(
                title: Text(state.comments![index].name),
                subtitle: Text(state.comments![index].body),
              );
            }),
        onRefresh: () => _onRefresh(context));
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<RemoteCommentBloc>(context)
        .add(GetRemoteComments(widget.postId));
  }
}
