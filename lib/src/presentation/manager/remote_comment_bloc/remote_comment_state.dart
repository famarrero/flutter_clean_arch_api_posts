part of 'remote_comment_bloc.dart';

abstract class RemoteCommentState {
  final List<CommentModel>? comments;
  final String? error;

  const RemoteCommentState({this.comments, this.error});
}

class RemoteCommentLoading extends RemoteCommentState {
  const RemoteCommentLoading();
}

class RemoteCommentError extends RemoteCommentState {
  const RemoteCommentError(String error) : super(error: error);
}

class RemoteCommentLoadingDone extends RemoteCommentState {
  const RemoteCommentLoadingDone(List<CommentModel> comments) : super(comments: comments);
}
