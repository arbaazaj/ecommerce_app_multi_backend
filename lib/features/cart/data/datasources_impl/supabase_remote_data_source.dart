import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCartRemoteDataSource implements CartRemoteDataSource {
  final SupabaseClient client;

  SupabaseCartRemoteDataSource(this.client);

  String get _userId {
    final user = client.auth.currentUser;
    if (user == null) throw const ServerException('User not authenticated');
    return user.id;
  }

  @override
  Future<CartItemModel> addToCart({
    required String productId,
    String? variantId,
    int quantity = 1,
  }) async {
    try {
      final response = await client
          .from('cart_items')
          .insert({
            'user_id': _userId,
            'product_id': productId,
            'variant_id': variantId,
            'quantity': quantity,
          })
          .select('*, products(*), product_variants(*)')
          .single();
      return CartItemModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await client.from('cart_items').delete().eq('user_id', _userId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CartItemModel>> getCart() async {
    try {
      final response = await client
          .from('cart_items')
          .select('*, products(*), product_variants(*)')
          .eq('user_id', _userId);
      return (response as List).map((e) => CartItemModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeFromCart(String cartItemId) async {
    try {
      await client
          .from('cart_items')
          .delete()
          .eq('id', cartItemId)
          .eq('user_id', _userId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CartItemModel> updateCartItem(String cartItemId, int quantity) async {
    try {
      final response = await client
          .from('cart_items')
          .update({'quantity': quantity})
          .eq('id', cartItemId)
          .eq('user_id', _userId)
          .select('*, products(*), product_variants(*)')
          .single();
      return CartItemModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
