import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';

class GetProductsParams {
  final String? categoryId;
  final String? searchQuery;
  final int limit;
  final int offset;

  const GetProductsParams({
    this.categoryId,
    this.searchQuery,
    this.limit = 20,
    this.offset = 0,
  });
}

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(GetProductsParams params) async {
    return await repository.getProducts(
      categoryId: params.categoryId,
      searchQuery: params.searchQuery,
      limit: params.limit,
      offset: params.offset,
    );
  }
}
