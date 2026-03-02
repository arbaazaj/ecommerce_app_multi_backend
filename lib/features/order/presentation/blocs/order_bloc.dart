import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/order/domain/usecases/get_orders_use_case.dart';
import 'package:ecommerce_app/features/order/domain/usecases/place_order_use_case.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrderUseCase placeOrderUseCase;
  final GetOrdersUseCase getOrdersUseCase;

  OrderBloc({required this.placeOrderUseCase, required this.getOrdersUseCase})
    : super(OrderInitial()) {
    on<PlaceOrderEvent>(_onPlaceOrder);
    on<GetOrdersEvent>(_onGetOrders);
  }

  Future<void> _onPlaceOrder(
    PlaceOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await placeOrderUseCase(
      PlaceOrderParams(
        shippingAddressId: event.shippingAddressId,
        paymentMethod: event.paymentMethod,
      ),
    );
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) => emit(OrderPlaced(order)),
    );
  }

  Future<void> _onGetOrders(
    GetOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await getOrdersUseCase(const NoParams());
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }
}
