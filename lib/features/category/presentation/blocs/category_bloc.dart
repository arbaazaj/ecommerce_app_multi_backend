import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/category/domain/usecases/get_categories_use_case.dart';
import 'package:ecommerce_app/features/category/presentation/blocs/category_event.dart';
import 'package:ecommerce_app/features/category/presentation/blocs/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc({required this.getCategoriesUseCase})
    : super(CategoryInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await getCategoriesUseCase(const NoParams());
    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }
}
