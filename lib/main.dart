import 'package:ecommerce_app/core/di/injection_container.dart';
import 'package:ecommerce_app/core/routes/app_router.dart';
import 'package:ecommerce_app/core/themes/app_theme_dark.dart';
import 'package:ecommerce_app/core/themes/app_theme_light.dart';
import 'package:ecommerce_app/core/utils/backend.dart';
import 'package:ecommerce_app/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:ecommerce_app/features/authentication/presentation/blocs/authentication_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/category/presentation/blocs/category_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late final Backend backend;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load .env file and initialize it.
  await dotenv.load(fileName: '.env');

  // Check for backend
  final backendString = dotenv.env['BACKEND'];
  backend = Backend.values.firstWhere(
    (e) => e.name == backendString?.toLowerCase(),
    orElse: () => Backend.supabase,
  );

  await Supabase.initialize(
    url: '${dotenv.env['SUPABASE_PROJECT_URL']}',
    anonKey: '${dotenv.env['SUPABASE_ANON_KEY']}',
  );

  // Initialize all backend (Comment or Uncomment to use or remove any backend)
  // For e.g.
  // final Client client  S= Client()
  //     .setEndpoint('${dotenv.env['APPWRITE_PUBLIC_ENDPOINT']}')
  //     .setProject('${dotenv.env['APPWRITE_PROJECT_ID']}');

  // Initialize dependency injection (Only initialize after declaring backend
  // config).
  await initDep(backend);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCheckRequested()),
        ),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
        BlocProvider(create: (context) => sl<ProductBloc>()),
        BlocProvider(create: (context) => sl<CartBloc>()),
        BlocProvider(create: (context) => sl<OrderBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Ecommerce App',
        theme: appThemeLight,
        darkTheme: appThemeDark,
        themeMode: ThemeMode.system,
        // Or read from settings
        routerConfig: appRouter,
      ),
    );
  }
}
