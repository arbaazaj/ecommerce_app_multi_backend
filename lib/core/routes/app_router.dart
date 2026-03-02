import 'package:ecommerce_app/core/presentation/pages/main_dashboard.dart';
import 'package:ecommerce_app/features/authentication/presentation/pages/login_page.dart';
import 'package:ecommerce_app/features/authentication/presentation/pages/register_page.dart';
import 'package:ecommerce_app/features/cart/presentation/pages/cart_page.dart';
import 'package:ecommerce_app/features/order/presentation/pages/checkout_page.dart';
import 'package:ecommerce_app/features/product/presentation/pages/product_detail_page.dart';
import 'package:ecommerce_app/features/profile/presentation/pages/notifications_page.dart';
import 'package:ecommerce_app/features/profile/presentation/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainDashboard()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) =>
          ProductDetailPage(productId: state.pathParameters['id']!),
    ),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
  ],
);
