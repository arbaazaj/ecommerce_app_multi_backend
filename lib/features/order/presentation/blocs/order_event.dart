import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrderEvent extends OrderEvent {
  final String shippingAddressId;
  final String paymentMethod;

  const PlaceOrderEvent({
    required this.shippingAddressId,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [shippingAddressId, paymentMethod];
}

class GetOrdersEvent extends OrderEvent {}
