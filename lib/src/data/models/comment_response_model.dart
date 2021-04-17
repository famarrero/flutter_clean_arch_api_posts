import 'package:flutter_app/src/data/models/comment_model.dart';

class CommentResponseModel {
  final List<CommentModel> comments;
  final String error;

  CommentResponseModel(this.comments, this.error);

  CommentResponseModel.fromJson(List<dynamic> json)
      : comments = (json).map((i) => new CommentModel.fromJson(i)).toList(),
        error = "";

  CommentResponseModel.withError(String errorValue)
      : comments = [],
        error = errorValue;
}
