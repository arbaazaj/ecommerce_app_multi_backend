import 'package:ecommerce_app/features/authentication/data/models/app_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AppUserModel> login({required String email, required String password});

  Future<AppUserModel> register({
    required String email,
    required String password,
    String? fullName,
  });

  Future<void> logout();

  Future<AppUserModel?> getCurrentUser();
}
