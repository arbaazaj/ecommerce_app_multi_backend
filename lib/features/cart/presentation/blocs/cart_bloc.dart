import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/update_cart_item_use_case.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartItemUseCase updateCartItemUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartItemUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial()) {
    on<GetCartEvent>(_onGetCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final result = await getCartUseCase(const NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItems) => emit(CartLoaded(cartItems)),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await addToCartUseCase(
      AddToCartParams(
        productId: event.productId,
        variantId: event.variantId,
        quantity: event.quantity,
      ),
    );
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => add(GetCartEvent()),
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await removeFromCartUseCase(event.cartItemId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => add(GetCartEvent()),
    );
  }

  Future<void> _onUpdateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await updateCartItemUseCase(
      UpdateCartItemParams(
        cartItemId: event.cartItemId,
        quantity: event.quantity,
      ),
    );
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => add(GetCartEvent()),
    );
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await clearCartUseCase(const NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => emit(const CartLoaded([])),
    );
  }
}
