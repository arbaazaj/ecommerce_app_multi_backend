import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class AddToCartParams {
  final String productId;
  final String? variantId;
  final int quantity;

  const AddToCartParams({
    required this.productId,
    this.variantId,
    this.quantity = 1,
  });
}

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<Either<Failure, CartItem>> call(AddToCartParams params) async {
    return await repository.addToCart(
      productId: params.productId,
      variantId: params.variantId,
      quantity: params.quantity,
    );
  }
}
