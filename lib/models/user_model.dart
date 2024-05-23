class UserModel {
  String uid;
  final String email;
  final String userName;

  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
  });

  Map<String, dynamic> toJson() =>
      {
        'username': userName,
        'uid': uid,
        'email': email,
      };
}
