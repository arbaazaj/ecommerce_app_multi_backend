import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/authentication/data/models/app_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient client;

  SupabaseAuthRemoteDataSource(this.client);

  @override
  Future<AppUserModel?> getCurrentUser() async {
    try {
      final user = client.auth.currentUser;
      if (user == null) return null;

      final res = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      if (res != null) {
        return AppUserModel.fromJson(res);
      }
      return AppUserModel(id: user.id, email: user.email ?? '');
    } catch (e) {
      throw ServerException('Failed to get current user: $e');
    }
  }

  @override
  Future<AppUserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) throw const ServerException('Login failed');

      final res = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      if (res != null) {
        return AppUserModel.fromJson(res);
      }
      return AppUserModel(id: user.id, email: user.email ?? '');
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AppUserModel> register({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: fullName != null ? {'full_name': fullName} : null,
      );
      final user = response.user;
      if (user == null) throw const ServerException('Registration failed');

      return AppUserModel(
        id: user.id,
        email: user.email ?? '',
        fullName: fullName,
      );
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
