import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    String? categoryId,
    String? searchQuery,
    int limit = 20,
    int offset = 0,
  });

  Future<Either<Failure, Product>> getProductById(String id);
}
