import 'package:flutter_app/src/core/usecase/usecase.dart';
import 'package:flutter_app/src/data/models/post_response_model.dart';
import 'package:flutter_app/src/domain/repositories/remote_repository.dart';

class GetRemotePostsUseCase implements UseCase<PostResponseModel, void> {
  final RemoteRepository _remoteRepository;

  GetRemotePostsUseCase(this._remoteRepository);

  @override
  Future<PostResponseModel> call({void params}) {
    return _remoteRepository.getPosts();
  }
}
