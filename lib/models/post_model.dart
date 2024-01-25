class Post {
  late String userId;
  late String firstname;
  late String date;
  late String content;
  String? image;

  Post({
    required this.userId,
    required this.firstname,
    required this.date,
    required this.content,
    this.image,
  });

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstname = json['firstname'];
    date = json['date'];
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstname': firstname,
    'date': date,
    'content': content,
    'image': image,
  };
}