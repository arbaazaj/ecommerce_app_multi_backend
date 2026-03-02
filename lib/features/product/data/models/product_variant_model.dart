import 'package:ecommerce_app/features/product/domain/entities/product_variant.dart';

class ProductVariantModel extends ProductVariant {
  const ProductVariantModel({
    required super.id,
    required super.productId,
    super.size,
    super.color,
    super.stockQuantity,
    super.priceAdjustment,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      size: json['size'] as String?,
      color: json['color'] as String?,
      stockQuantity: (json['stock_quantity'] as num?)?.toInt() ?? 0,
      priceAdjustment: (json['price_adjustment'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
