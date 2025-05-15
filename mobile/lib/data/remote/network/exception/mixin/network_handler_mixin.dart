import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../app_exception.dart';
import '../../../../../models/response/response.dart' as response;
import '../../network_service.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, response.Response>>
      handleException<T extends Object>(
          Future<Response<dynamic>> Function() handler,
          {String endPoint = ''}) async {
    try {
      final res = await handler();
      return Right(response.Response(
        statusCode: res.statusCode ?? 200,
        data: res.data,
        statusMessage: res.statusMessage,
      ));
    } catch (ex) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      switch (ex.runtimeType) {
        case const (SocketException):
          ex as SocketException;
          message = 'unable to connect to the server.';
          statusCode = 0;
          identifier = 'Socket Exception ${ex.message}\n at  $endPoint';
          break;

        case const (DioException):
          ex as DioException;
          switch (ex.response?.statusCode) {
            case null:
              message = 'Erro interno ocorreu';
              break;
            case 404:
              message = 'Não encontrado';
              break;
            case 401:
              message = 'Autenticação necessária';
              break;
            case 500:
              message = 'Erro interno ocorreu';
              break;
            default:
              message = ex.response != null && ex.response?.data != null
                  ? ex.response!.data!['error'].toString()
                  : 'Internal Error occurred';
          }
          statusCode = 0;
          identifier = 'Dio Exception ${ex.message}\n at  $endPoint';
          break;

        default:
          message = 'unknown error occurred';
          statusCode = 0;
          identifier = 'unknown error ${ex.toString()}\n at  $endPoint';
          break;
      }
      return Left(AppException(
          title: message,
          message: message,
          statusCode: statusCode,
          identifier: identifier,
          which: 'http'));
    }
  }
}
