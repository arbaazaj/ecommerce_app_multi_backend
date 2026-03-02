import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/app_user.dart';
import 'package:ecommerce_app/features/authentication/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, AppUser?>> call() async {
    return await repository.getCurrentUser();
  }
}
