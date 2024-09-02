class CommentResModel {
  List<Comment>? comment;

  CommentResModel({this.comment});

  CommentResModel.fromJson(Map<String, dynamic> json) {
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? id;
  int? userId;
  int? postId;
  String? text;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comment(
      {this.id,
      this.userId,
      this.postId,
      this.text,
      this.createdAt,
      this.updatedAt,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? profileImage;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.profileImage,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
