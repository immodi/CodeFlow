class PasswordResetModel {
  final String email;

  PasswordResetModel({required this.email});

  factory PasswordResetModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetModel(email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
