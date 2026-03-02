import 'package:ecommerce_app/features/order/domain/entities/order_item.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/models/product_variant_model.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.id,
    required super.product,
    super.variant,
    required super.quantity,
    required super.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      product: ProductModel.fromJson(json['products'] as Map<String, dynamic>),
      variant: json['product_variants'] != null
          ? ProductVariantModel.fromJson(
              json['product_variants'] as Map<String, dynamic>,
            )
          : null,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );
  }
}
