import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/app_user.dart';
import 'package:ecommerce_app/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AppUser>> call({
    required String email,
    required String password,
    String? fullName,
  }) async {
    return await repository.register(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
