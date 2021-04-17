class PostModel {
  final int postId;
  final int userId;
  final String title;

  PostModel(this.postId, this.userId, this.title);

  PostModel.fromJson(Map<String, dynamic> json)
      : postId = json["id"],
        userId = json["userId"],
        title = json["title"];

  @override
  String toString() {
    return 'PostModel{postId: $postId, userId: $userId, title: $title}';
  }
}
