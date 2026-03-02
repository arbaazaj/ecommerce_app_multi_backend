import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductRemoteDataSource implements ProductRemoteDataSource {
  final SupabaseClient client;

  SupabaseProductRemoteDataSource(this.client);

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await client
          .from('products')
          .select('*, product_variants(*)')
          .eq('id', id)
          .single();
      return ProductModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? searchQuery,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      var query = client.from('products').select('*, product_variants(*)');

      if (categoryId != null && categoryId.isNotEmpty) {
        query = query.eq('category_id', categoryId);
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.ilike('name', '%$searchQuery%');
      }

      final response = await query.range(offset, offset + limit - 1);
      return (response as List).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
