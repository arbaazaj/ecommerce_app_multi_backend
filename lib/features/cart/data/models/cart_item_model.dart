import 'package:ecommerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/models/product_variant_model.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.userId,
    required super.product,
    super.variant,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      product: ProductModel.fromJson(json['products'] as Map<String, dynamic>),
      variant: json['product_variants'] != null
          ? ProductVariantModel.fromJson(
              json['product_variants'] as Map<String, dynamic>,
            )
          : null,
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': product.id,
      'variant_id': variant?.id,
      'quantity': quantity,
    };
  }
}
