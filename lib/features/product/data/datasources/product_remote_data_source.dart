import 'package:ecommerce_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? searchQuery,
    int limit = 20,
    int offset = 0,
  });
  Future<ProductModel> getProductById(String id);
}
