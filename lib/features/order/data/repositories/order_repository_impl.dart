import 'package:dartz/dartz.dart' hide Order;
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:ecommerce_app/features/order/domain/entities/order.dart';
import 'package:ecommerce_app/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    try {
      final orders = await remoteDataSource.getOrders();
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Order>> placeOrder({
    required String shippingAddressId,
    required String paymentMethod,
  }) async {
    try {
      final order = await remoteDataSource.placeOrder(
        shippingAddressId: shippingAddressId,
        paymentMethod: paymentMethod,
      );
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
