import 'package:ecommerce_app/features/product/domain/entities/product_variant.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double price;
  final double? discountPrice;
  final String? categoryId;
  final List<String> imageUrls;
  final int stockQuantity;
  final bool isFeatured;
  final List<ProductVariant> variants;

  const Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.discountPrice,
    this.categoryId,
    this.imageUrls = const [],
    this.stockQuantity = 0,
    this.isFeatured = false,
    this.variants = const [],
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    discountPrice,
    categoryId,
    imageUrls,
    stockQuantity,
    isFeatured,
    variants,
  ];
}
