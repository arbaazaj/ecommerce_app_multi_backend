import 'package:dartz/dartz.dart' hide Order;
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/order/domain/entities/order.dart';
import 'package:ecommerce_app/features/order/domain/repositories/order_repository.dart';

class GetOrdersUseCase {
  final OrderRepository repository;

  GetOrdersUseCase(this.repository);

  Future<Either<Failure, List<Order>>> call(NoParams params) async {
    return await repository.getOrders();
  }
}
