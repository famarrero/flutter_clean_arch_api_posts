import 'package:flutter_app/src/data/data_sources/remote_data/post_api_provider.dart';
import 'package:flutter_app/src/data/models/comment_response_model.dart';
import 'package:flutter_app/src/data/models/post_response_model.dart';
import 'package:flutter_app/src/domain/repositories/remote_repository.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  final PostApiProvider _postApiProvider;

  const RemoteRepositoryImpl(this._postApiProvider);

  @override
  Future<PostResponseModel> getPosts() {
    return _postApiProvider.getPosts();
  }

  @override
  Future<CommentResponseModel> getCommentsByPostId(int postId) {
    return _postApiProvider.getCommentsByPostId(postId);
  }
}
