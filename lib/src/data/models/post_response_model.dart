import 'package:flutter_app/src/data/models/post_model.dart';

class PostResponseModel {
  final List<PostModel> posts;
  final String error;

  PostResponseModel(this.posts, this.error);

  PostResponseModel.fromJson(List<dynamic> json)
      : posts = (json).map((i) => new PostModel.fromJson(i)).toList(),
        error = "";

  PostResponseModel.withError(String errorValue)
      : posts = [],
        error = errorValue;
}
