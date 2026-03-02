import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:ecommerce_app/features/order/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOrderRemoteDataSource implements OrderRemoteDataSource {
  final SupabaseClient client;

  SupabaseOrderRemoteDataSource(this.client);

  String get _userId {
    final user = client.auth.currentUser;
    if (user == null) throw const ServerException('User not authenticated');
    return user.id;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await client
          .from('orders')
          .select('*, order_items(*, products(*), product_variants(*))')
          .eq('user_id', _userId)
          .order('created_at', ascending: false);

      return (response as List).map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<OrderModel> placeOrder({
    required String shippingAddressId,
    required String paymentMethod,
  }) async {
    try {
      // 1. Get cart items
      final cartResponse = await client
          .from('cart_items')
          .select('*, products(price)')
          .eq('user_id', _userId);

      final cartItems = cartResponse as List;
      if (cartItems.isEmpty) {
        throw const ServerException('Cart is empty');
      }

      // Calculate total
      double total = 0;
      for (var item in cartItems) {
        final qty = (item['quantity'] as num).toInt();
        final price = (item['products']['price'] as num).toDouble();
        total += (qty * price);
      }

      // 2. Create Order
      final orderResponse = await client
          .from('orders')
          .insert({
            'user_id': _userId,
            'total_amount': total,
            'status': 'pending',
            'payment_method': paymentMethod,
            'shipping_address_id': shippingAddressId,
          })
          .select()
          .single();

      final orderId = orderResponse['id'] as String;

      // 3. Create Order Items
      final orderItemsData = cartItems.map((item) {
        return {
          'order_id': orderId,
          'product_id': item['product_id'],
          'variant_id': item['variant_id'],
          'quantity': item['quantity'],
          'price': (item['products']['price'] as num).toDouble(),
        };
      }).toList();

      await client.from('order_items').insert(orderItemsData);

      // 4. Clear Cart
      await client.from('cart_items').delete().eq('user_id', _userId);

      // 5. Fetch full order
      final fullOrderResponse = await client
          .from('orders')
          .select('*, order_items(*, products(*), product_variants(*))')
          .eq('id', orderId)
          .single();

      return OrderModel.fromJson(fullOrderResponse);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
