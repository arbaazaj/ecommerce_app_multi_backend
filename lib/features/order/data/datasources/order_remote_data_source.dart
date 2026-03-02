import 'package:ecommerce_app/features/order/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> placeOrder({
    required String shippingAddressId,
    required String paymentMethod,
  });

  Future<List<OrderModel>> getOrders();
}
