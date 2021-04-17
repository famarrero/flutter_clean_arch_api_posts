class CommentModel {
  final int postId;
  final int commentId;
  final String name;
  final String email;
  final String body;

  CommentModel(this.postId, this.commentId, this.name, this.email, this.body);

  CommentModel.fromJson(Map<String, dynamic> json)
      : postId = json["postId"],
        commentId = json["id"],
        name = json["name"],
        email = json["email"],
        body = json["body"];

  @override
  String toString() {
    return 'CommentModel{postId: $postId, commentId: $commentId, name: $name, email: $email, body: $body}';
  }
}
