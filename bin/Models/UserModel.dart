// ignore_for_file: file_names

class UserModel {
  final int? id;
  final String? name;
  final String? bio;
  final String username;
  final String email;
  final String idAuth;

  UserModel({
    this.id,
    this.name,
    this.bio,
    required this.username,
    required this.email,
    required this.idAuth,
  });

  factory UserModel.fromJson({required Map json}) {
    return UserModel(
      id: json["id"],
      name: json['name'],
      bio: json['bio'],
      username: json['username'],
      email: json['email'],
      idAuth: json['id_auth'],
    );
  }

  toMap() {
    final jsonMap = {
      "name": name ?? 'Guest',
      "bio": bio,
      "username": username,
      "email": email,
      "id_auth": idAuth,
    };

    if (id == null) {
      return jsonMap;
    }

    return {"id": id, ...jsonMap};
  }
}
