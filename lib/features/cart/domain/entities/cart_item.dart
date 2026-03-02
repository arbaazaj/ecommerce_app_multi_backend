import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_variant.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String userId;
  final Product product;
  final ProductVariant? variant;
  final int quantity;

  const CartItem({
    required this.id,
    required this.userId,
    required this.product,
    this.variant,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, userId, product, variant, quantity];
}
