import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class GetCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productId;
  final String? variantId;
  final int quantity;

  const AddToCartEvent({
    required this.productId,
    this.variantId,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [productId, variantId, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final String cartItemId;

  const RemoveFromCartEvent(this.cartItemId);

  @override
  List<Object?> get props => [cartItemId];
}

class UpdateCartItemEvent extends CartEvent {
  final String cartItemId;
  final int quantity;

  const UpdateCartItemEvent(this.cartItemId, this.quantity);

  @override
  List<Object?> get props => [cartItemId, quantity];
}

class ClearCartEvent extends CartEvent {}
