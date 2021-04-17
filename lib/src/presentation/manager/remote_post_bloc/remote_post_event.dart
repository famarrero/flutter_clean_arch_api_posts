part of 'remote_post_bloc.dart';

abstract class RemotePostEvent {
  const RemotePostEvent();
}

class GetRemotePosts extends RemotePostEvent {
  const GetRemotePosts();
}
