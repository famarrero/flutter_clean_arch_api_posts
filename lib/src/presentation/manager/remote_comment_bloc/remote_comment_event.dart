part of 'remote_comment_bloc.dart';

abstract class RemoteCommentEvent {
  final int postId;

  const RemoteCommentEvent({required this.postId});
}

class GetRemoteComments extends RemoteCommentEvent {
  const GetRemoteComments(int postId)
      : super(postId: postId);
}
