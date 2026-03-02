import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_variant.dart';
import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String id;
  final Product product;
  final ProductVariant? variant;
  final int quantity;
  final double price;

  const OrderItem({
    required this.id,
    required this.product,
    this.variant,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [id, product, variant, quantity, price];
}
