import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCart();
  Future<CartItemModel> addToCart({
    required String productId,
    String? variantId,
    int quantity = 1,
  });
  Future<CartItemModel> updateCartItem(String cartItemId, int quantity);
  Future<void> removeFromCart(String cartItemId);
  Future<void> clearCart();
}
