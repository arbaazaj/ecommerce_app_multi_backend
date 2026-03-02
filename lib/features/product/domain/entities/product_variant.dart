import 'package:equatable/equatable.dart';

class ProductVariant extends Equatable {
  final String id;
  final String productId;
  final String? size;
  final String? color;
  final int stockQuantity;
  final double priceAdjustment;

  const ProductVariant({
    required this.id,
    required this.productId,
    this.size,
    this.color,
    this.stockQuantity = 0,
    this.priceAdjustment = 0.0,
  });

  @override
  List<Object?> get props => [
    id,
    productId,
    size,
    color,
    stockQuantity,
    priceAdjustment,
  ];
}
