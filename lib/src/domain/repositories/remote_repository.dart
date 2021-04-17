import 'package:flutter_app/src/data/models/comment_response_model.dart';
import 'package:flutter_app/src/data/models/post_response_model.dart';

abstract class RemoteRepository {
  Future<PostResponseModel> getPosts();

  Future<CommentResponseModel> getCommentsByPostId(int postId);
}
