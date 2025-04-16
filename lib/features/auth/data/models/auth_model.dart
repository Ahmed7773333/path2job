// lib/features/auth/data/models/auth_model.dart

class AuthModel {
  final String email;
  final String password;
  final String? name;
  final String? job;
  final String? phone;

  AuthModel({
    required this.email,
    required this.password,
    this.name,
    this.job,
    this.phone,
  });
}
