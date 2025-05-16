import 'package:get_it/get_it.dart';

import '../data/local/secure_storage/secure_storage.dart';
import '../data/local/secure_storage/secure_storage_impl.dart';
import '../data/remote/network/dio_network_service.dart';
import '../data/remote/network/network_service.dart';

final injector = GetIt.instance;

Future<void> initSingletons() async {
  //Services
  injector.registerLazySingleton<NetworkService>(() => DioNetworkService());
  injector.registerLazySingleton<SecureStorage>(
    () => SecureStorageImplementation(),
  );
}
