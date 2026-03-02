import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartItemParams {
  final String cartItemId;
  final int quantity;

  const UpdateCartItemParams({
    required this.cartItemId,
    required this.quantity,
  });
}

class UpdateCartItemUseCase {
  final CartRepository repository;

  UpdateCartItemUseCase(this.repository);

  Future<Either<Failure, CartItem>> call(UpdateCartItemParams params) async {
    return await repository.updateCartItem(params.cartItemId, params.quantity);
  }
}
