import 'package:flutter_app/src/core/usecase/usecase.dart';
import 'package:flutter_app/src/data/models/comment_response_model.dart';
import 'package:flutter_app/src/domain/repositories/remote_repository.dart';

class GetRemoteCommentsByPostIdUseCase
    implements UseCase<CommentResponseModel, int> {
  final RemoteRepository _remoteRepository;

  GetRemoteCommentsByPostIdUseCase(this._remoteRepository);

  @override
  Future<CommentResponseModel> call({required int params}) {
    return _remoteRepository.getCommentsByPostId(params);
  }
}
