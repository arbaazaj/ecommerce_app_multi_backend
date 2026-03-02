import 'package:ecommerce_app/core/utils/backend.dart';
import 'package:ecommerce_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/authentication/data/datasources_impl/supabase_remote_data_source.dart';
import 'package:ecommerce_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/get_current_user_use_case.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/login_use_case.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/logout_use_case.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/register_use_case.dart';
import 'package:ecommerce_app/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/datasources_impl/supabase_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/update_cart_item_use_case.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/category/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_app/features/category/data/datasources_impl/supabase_remote_data_source.dart';
import 'package:ecommerce_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/features/category/domain/repositories/category_repository.dart';
import 'package:ecommerce_app/features/category/domain/usecases/get_categories_use_case.dart';
import 'package:ecommerce_app/features/category/presentation/blocs/category_bloc.dart';
import 'package:ecommerce_app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:ecommerce_app/features/order/data/datasources_impl/supabase_remote_data_source.dart';
import 'package:ecommerce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_app/features/order/domain/repositories/order_repository.dart';
import 'package:ecommerce_app/features/order/domain/usecases/get_orders_use_case.dart';
import 'package:ecommerce_app/features/order/domain/usecases/place_order_use_case.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_bloc.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/datasources_impl/supabase_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_products_use_case.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDep(Backend backend) async {
  // Blocs
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );
  sl.registerFactory(() => CategoryBloc(getCategoriesUseCase: sl()));
  sl.registerFactory(
    () => ProductBloc(getProductsUseCase: sl(), getProductByIdUseCase: sl()),
  );
  sl.registerFactory(
    () => CartBloc(
      getCartUseCase: sl(),
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl(),
      updateCartItemUseCase: sl(),
      clearCartUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => OrderBloc(placeOrderUseCase: sl(), getOrdersUseCase: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUseCase(sl()));

  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartItemUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));

  sl.registerLazySingleton(() => PlaceOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  if (backend == Backend.supabase) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => SupabaseAuthRemoteDataSource(Supabase.instance.client),
    );
    sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => SupabaseCategoryRemoteDataSource(Supabase.instance.client),
    );
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => SupabaseProductRemoteDataSource(Supabase.instance.client),
    );
    sl.registerLazySingleton<CartRemoteDataSource>(
      () => SupabaseCartRemoteDataSource(Supabase.instance.client),
    );
    sl.registerLazySingleton<OrderRemoteDataSource>(
      () => SupabaseOrderRemoteDataSource(Supabase.instance.client),
    );
  }
}
