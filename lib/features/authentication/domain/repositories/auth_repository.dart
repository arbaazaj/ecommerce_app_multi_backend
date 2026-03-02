import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUser>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, AppUser>> register({
    required String email,
    required String password,
    String? fullName,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AppUser?>> getCurrentUser();
}
