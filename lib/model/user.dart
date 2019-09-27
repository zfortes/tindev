class User{
  var likes;
  var dislikes;
  var id;
  String name;
  String user;
  String bio;
  String avatar;

  User({
      this.id,
      this.name,
      this.user,
      this.bio,
      this.avatar,
  });


  factory User.fromJson(Map<String, dynamic> json){
    return new User(
      id: json['_id'],
      name: json['name'],
      user: json['user'],
      bio: json['bio'],
      avatar: json['avatar'],
    );
  }

}