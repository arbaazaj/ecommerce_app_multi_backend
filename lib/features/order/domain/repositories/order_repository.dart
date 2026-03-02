import 'package:dartz/dartz.dart' hide Order;
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/order/domain/entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, Order>> placeOrder({
    required String shippingAddressId,
    required String paymentMethod,
  });

  Future<Either<Failure, List<Order>>> getOrders();
}
