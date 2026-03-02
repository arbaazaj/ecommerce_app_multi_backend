import 'package:ecommerce_app/features/product/data/models/product_variant_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    super.description,
    required super.price,
    super.discountPrice,
    super.categoryId,
    super.imageUrls,
    super.stockQuantity,
    super.isFeatured,
    super.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      categoryId: json['category_id'] as String?,
      imageUrls:
          (json['image_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      stockQuantity: (json['stock_quantity'] as num?)?.toInt() ?? 0,
      isFeatured: json['is_featured'] as bool? ?? false,
      variants:
          (json['product_variants'] as List<dynamic>?)
              ?.map(
                (v) => ProductVariantModel.fromJson(v as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}
