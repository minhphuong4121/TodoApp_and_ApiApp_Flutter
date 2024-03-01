class UserPic {
  String? thumbnail;

  UserPic({this.thumbnail});

  factory UserPic.fromMap(Map<String, dynamic> e) {
    return UserPic(
      thumbnail: e['thumbnail'],
    );
  }
}
