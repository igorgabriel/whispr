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

// void provideDataSources() {
//   // login
//   injector.registerFactory<LoginRemoteDataSource>(() =>
//       LoginRemoteDataSourceImpl(
//           networkService: injector.get<NetworkService>()));

//   // injector.registerFactory<AccountRemoteDataSource>(() =>
//   //     AccountRemoteDataSourceImpl(
//   //         networkService: injector.get<NetworkService>()));

//   injector.registerFactory<HomeRemoteDataSource>(() =>
//       HomeRemoteDataSourceImpl(networkService: injector.get<NetworkService>()));

//   // injector.registerFactory<UploadRemoteDataSource>(() =>
//   //     UploadRemoteDataSourceImpl(
//   //         networkService: injector.get<NetworkService>()));

//   // injector.registerFactory<VideoPlayerRemoteDataSource>(() =>
//   //     VideoPlayerRemoteDataSourceImpl(
//   //         networkService: injector.get<NetworkService>()));

//   // injector.registerFactory<PaymentRemoteDataSource>(() =>
//   //     PaymentRemoteDataSourceImpl(
//   //         networkService: injector.get<NetworkService>()));
// }

// void provideRepositories() {
//   // login
//   injector.registerFactory<LoginRepository>(() => LoginRepositoryImpl(
//       homeRemoteDataSource: injector.get<LoginRemoteDataSource>()));

//   // injector.registerFactory<AccountRepository>(() => AccountRepositoryImpl(
//   //     accountRemoteDataSource: injector.get<AccountRemoteDataSource>()));

//   injector.registerFactory<HomeRepository>(() => HomeRepositoryImpl(
//       homeRemoteDataSource: injector.get<HomeRemoteDataSource>()));

//   // injector.registerFactory<UploadRepository>(() => UploadRepositoryImpl(
//   //     uploadRemoteDataSource: injector.get<UploadRemoteDataSource>()));

//   // injector.registerFactory<VideoPlayerRepository>(() =>
//   //     VideoPlayerRepositoryImpl(
//   //         videoPlayerRemoteDataSource:
//   //             injector.get<VideoPlayerRemoteDataSource>()));

//   // injector.registerFactory<PaymentRepository>(() => PaymentRepositoryImpl(
//   //     paymentRemoteDataSource: injector.get<PaymentRemoteDataSource>()));
// }

// void provideUseCases() {
//   // login
//   injector.registerFactory<LoginUseCase>(
//       () => LoginUseCase(loginRepository: injector.get<LoginRepository>()));
//   injector.registerFactory<RegisterUseCase>(
//       () => RegisterUseCase(loginRepository: injector.get<LoginRepository>()));

//   // injector.registerFactory<AccountUseCase>(() =>
//   //     AccountUseCase(accountRepository: injector.get<AccountRepository>()));

//   injector.registerFactory<HomeUseCase>(
//       () => HomeUseCase(homeRepository: injector.get<HomeRepository>()));

//   // injector.registerFactory<UploadUseCase>(
//   //     () => UploadUseCase(uploadRepository: injector.get<UploadRepository>()));

//   // injector.registerFactory<DeleteFileUseCase>(
//   //     () => DeleteFileUseCase(homeRepository: injector.get<HomeRepository>()));

//   // injector.registerFactory<VideoPlayerUseCase>(() => VideoPlayerUseCase(
//   //     videoPlayerRepository: injector.get<VideoPlayerRepository>()));

//   // injector.registerFactory<PixPaymentUseCase>(() =>
//   //     PixPaymentUseCase(paymentRepository: injector.get<PaymentRepository>()));

//   // injector.registerFactory<CreditCardPaymentUseCase>(() =>
//   //     CreditCardPaymentUseCase(
//   //         paymentRepository: injector.get<PaymentRepository>()));
// }
