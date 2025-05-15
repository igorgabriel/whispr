import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../models/response/response.dart' as response;
import '../../app_exception.dart';
import 'network_service.dart';
import 'exception/mixin/network_handler_mixin.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  late Dio dio;

  DioNetworkService() {
    dio = Dio();
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  BaseOptions get dioBaseOptions => BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  );

  @override
  String get baseUrl =>
      dotenv.env[NetworkEnv.BASEURL.name] ??
      'https://whispr-api.herokuapp.com/';

  @override
  String get apiKey => dotenv.env[NetworkEnv.APIKEY.name] ?? '';

  @override
  Map<String, Object> get headers => {
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  @override
  Map<String, dynamic>? updateHeaders(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    dio.options.headers = headers;
    return header;
  }

  @override
  Future<Either<AppException, response.Response>> get(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    queryParams ??= {};
    // queryParams[Params.apiKey] = apiKey;
    final res = handleException(
      () => dio.get(endPoint, queryParameters: queryParams, options: options),
      endPoint: endPoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> post(
    String endPoint, {
    Map<String, dynamic>? data,
    Options? options,
  }) {
    // queryParams[Params.apiKey] = apiKey;
    final res = handleException(
      () => dio.post(endPoint, data: data, options: options),
      endPoint: endPoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> postFile(
    String endPoint, {
    required Map<String, dynamic> data,
    required String filePath,
    Options? options,
  }) async {
    data['file'] = await MultipartFile.fromFile(
      filePath,
      filename: filePath.split('/').last,
    );
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      ),
      'Titulo': data['Titulo'],
      'Descricao': data['Descricao'],
    });

    final res = handleException(
      () => dio.post(endPoint, data: formData, options: options),
      endPoint: endPoint,
    );
    return res;
  }
}
