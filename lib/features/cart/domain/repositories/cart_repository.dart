import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCart();
  Future<Either<Failure, CartItem>> addToCart({
    required String productId,
    String? variantId,
    int quantity = 1,
  });
  Future<Either<Failure, CartItem>> updateCartItem(
    String cartItemId,
    int quantity,
  );
  Future<Either<Failure, void>> removeFromCart(String cartItemId);
  Future<Either<Failure, void>> clearCart();
}
