import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data/app_exception.dart';
import '../data/remote/network/network_service.dart';
import '../data/remote/network/network_values.dart';
import '../di/injector.dart';
import '../models/replyAI.dart';

class HowDoYouFeelService {
  Future<Either<AppException, Response>> post(String text) async {
    final NetworkService networkService = injector.get<NetworkService>();

    final response = await networkService.post(
      EndPoints.confession,
      data: {'text': text, 'language': 'pt'},
    );

    return response.fold((l) => Left(l), (r) {
      if (r.statusCode != 200) {
        return Left(
          AppException(
            identifier: EndPoints.confession,
            statusCode: r.statusCode,
            title: r.data['errors'] ?? 'Erro ao postar',
            message: r.statusMessage,
            which: 'http',
          ),
        );
      }

      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: EndPoints.confession,
            statusCode: 0,
            title: r.data['errors'] ?? 'Erro ao postar',
            message: 'The data is not in the valid format',
            which: 'http',
          ),
        );
      }

      final response = ReplyAI.fromJson(jsonData);
      return Right(
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: response,
        ),
      );
    });
  }
}
