import 'package:ecommerce_app/core/utils/backend.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDep(
  Backend backend /* Client client Optional parameters can be added here
for backends client instance */,
) async {
  // Here backend data-source will be switched automatically depending on what
  // backend is selected in the .env file.
  // For e.g.
  // if (backend == Backend.appwrite)
  /* sl.registerLazySingleton<Client>(() => client);
  // Switching data source here
  sl.registerLazySingleton<RemoteDataSource>(() {
    switch (backend) {
      case Backend.appwrite:
        return AppwriteDataSource(sl<Client>());
      case Backend.firebase:
        return FirebaseDataSource(sl<Firebase>());
    }
  });
   */
}
