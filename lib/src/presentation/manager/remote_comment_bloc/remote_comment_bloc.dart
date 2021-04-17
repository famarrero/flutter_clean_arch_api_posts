import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/src/data/models/comment_model.dart';
import 'package:flutter_app/src/domain/use_cases/get_remote_comments_usecase.dart';

part 'remote_comment_event.dart';

part 'remote_comment_state.dart';

class RemoteCommentBloc extends Bloc<RemoteCommentEvent, RemoteCommentState> {
  final GetRemoteCommentsByPostIdUseCase _getRemoteCommentsByPostIdUseCase;

  RemoteCommentBloc(this._getRemoteCommentsByPostIdUseCase)
      : super(RemoteCommentLoading());

  @override
  Stream<RemoteCommentState> mapEventToState(
    RemoteCommentEvent event,
  ) async* {
    if (event is GetRemoteComments) {
      yield RemoteCommentLoading();
      yield* _getRemoteComments(event.postId);
    }
  }

  Stream<RemoteCommentState> _getRemoteComments(int postId) async* {
    final response = await _getRemoteCommentsByPostIdUseCase(params: postId);
    if (response.comments.isEmpty) {
      yield RemoteCommentError(response.error);
    } else {
      yield RemoteCommentLoadingDone(response.comments);
    }
  }
}
