import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/category/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_app/features/category/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCategoryRemoteDataSource implements CategoryRemoteDataSource {
  final SupabaseClient client;

  SupabaseCategoryRemoteDataSource(this.client);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await client.from('categories').select();
      return (response as List).map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
