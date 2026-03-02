import 'package:ecommerce_app/core/di/injection_container.dart';
import 'package:ecommerce_app/core/utils/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  // Initialize all backend (Comment or Uncomment to use or remove any backend)
  // For e.g.
  // final Client client = Client()
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
    return MaterialApp(
      title: 'Ecommerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
