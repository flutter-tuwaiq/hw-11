class UserModel {
  final String? name;
  final String email;
  final String username;
  final String idAuth;
  final String? bio;

  UserModel(
      {this.name,
      required this.email,
      required this.username,
      required this.idAuth,
      this.bio});

  factory UserModel.fromJson({required Map json}) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      idAuth: json['id_auth'],
      bio: json['bio'],
    );
  }

  toMap() {
    return {
      "name": name ?? 'Guest',
      "email": email,
      "username": username,
      "id_auth": idAuth,
      "bio": bio
    };
  }
}
