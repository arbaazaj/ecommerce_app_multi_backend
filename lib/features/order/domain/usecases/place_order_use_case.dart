import 'package:dartz/dartz.dart' hide Order;
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/order/domain/entities/order.dart';
import 'package:ecommerce_app/features/order/domain/repositories/order_repository.dart';

class PlaceOrderParams {
  final String shippingAddressId;
  final String paymentMethod;

  const PlaceOrderParams({
    required this.shippingAddressId,
    required this.paymentMethod,
  });
}

class PlaceOrderUseCase {
  final OrderRepository repository;

  PlaceOrderUseCase(this.repository);

  Future<Either<Failure, Order>> call(PlaceOrderParams params) async {
    return await repository.placeOrder(
      shippingAddressId: params.shippingAddressId,
      paymentMethod: params.paymentMethod,
    );
  }
}
