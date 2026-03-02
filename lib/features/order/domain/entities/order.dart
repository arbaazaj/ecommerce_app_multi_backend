import 'package:ecommerce_app/features/order/domain/entities/order_item.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String userId;
  final double totalAmount;
  final String status;
  final String? paymentMethod;
  final String? shippingAddressId;
  final List<OrderItem> items;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    this.paymentMethod,
    this.shippingAddressId,
    required this.items,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    totalAmount,
    status,
    paymentMethod,
    shippingAddressId,
    items,
    createdAt,
  ];
}
