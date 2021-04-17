import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/src/data/models/post_model.dart';
import 'package:flutter_app/src/domain/use_cases/get_remote_posts_usecase.dart';

part 'remote_post_event.dart';

part 'remote_post_state.dart';

class RemotePostBloc extends Bloc<RemotePostEvent, RemotePostState> {
  final GetRemotePostsUseCase _getRemotePostsUseCase;

  RemotePostBloc(this._getRemotePostsUseCase) : super(const RemotePostLoading());

  @override
  Stream<RemotePostState> mapEventToState(
    RemotePostEvent event,
  ) async* {
    if (event is GetRemotePosts) {
      yield RemotePostLoading();
      yield* _getRemotePosts();
    }
  }

  Stream<RemotePostState> _getRemotePosts() async* {
    final response = await _getRemotePostsUseCase();
    if (response.posts.isEmpty) {
      yield RemotePostError(response.error);
    } else {
      yield RemotePostLoadingDone(response.posts);
    }
  }
}
