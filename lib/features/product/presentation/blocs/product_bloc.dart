import 'package:ecommerce_app/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_products_use_case.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.getProductByIdUseCase,
  }) : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductByIdEvent>(_onGetProductById);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProductsUseCase(
      GetProductsParams(
        categoryId: event.categoryId,
        searchQuery: event.searchQuery,
      ),
    );
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onGetProductById(
    GetProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProductByIdUseCase(event.id);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }
}
