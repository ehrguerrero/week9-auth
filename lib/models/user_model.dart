import 'dart:convert';

class UserDeets {
  String email;
  String firstName;
  String lastName;

  UserDeets({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  // Factory constructor to instantiate object from json format
  factory UserDeets.fromJson(Map<String, dynamic> json) {
    return UserDeets(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  static List<UserDeets> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserDeets>((dynamic d) => UserDeets.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(UserDeets user) {
    return {
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
    };
  }
}
