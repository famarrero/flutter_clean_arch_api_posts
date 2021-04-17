import 'package:dio/dio.dart';
import 'package:flutter_app/src/data/models/comment_response_model.dart';
import 'package:flutter_app/src/data/models/post_response_model.dart';

class PostApiProvider {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";
  final Dio _dio;

  PostApiProvider(this._dio) {
    BaseOptions options =
        BaseOptions(baseUrl: _baseUrl, receiveTimeout: 5000, connectTimeout: 5000);
    _dio.options = options;
  }

  Future<PostResponseModel> getPosts() async {
    try {
      Response response = await _dio.get("/posts");
      return PostResponseModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return PostResponseModel.withError(_handleError(error));
    }
  }

  Future<CommentResponseModel> getCommentsByPostId(int postId) async {
    try {
      Response response = await _dio.get("/comments?postId=$postId");
      return CommentResponseModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return CommentResponseModel.withError(_handleError(error));
    }
  }

  String _handleError(Object error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${dioError.response!.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
