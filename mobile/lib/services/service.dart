import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data/app_exception.dart';

class Service {
  Future<Either<AppException, Response>> fetch() async {
    // final NetworkService networkService = injector.get<NetworkService>();

    // final response = await networkService.get(
    //   '${EndPoints.buscar}?chave=$chave&latitude=$latitude&longitude=$longitude&limit=30&offset=$offset',
    // );

    // return response.fold((l) => Left(l), (r) {
    //   if (r.statusCode != 200) {
    //     return Left(
    //       AppException(
    //         identifier: EndPoints.buscar,
    //         statusCode: r.statusCode,
    //         title: r.data['errors'] ?? 'Erro ao buscar',
    //         message: r.statusMessage,
    //         which: 'http',
    //       ),
    //     );
    //   }

    //   final jsonData = r.data;
    //   if (jsonData == null) {
    //     return Left(
    //       AppException(
    //         identifier: EndPoints.buscar,
    //         statusCode: 0,
    //         title: r.data['errors'] ?? 'Erro ao buscar',
    //         message: 'The data is not in the valid format',
    //         which: 'http',
    //       ),
    //     );
    //   }

    // final response = EmpresaResponse.fromJsonList(jsonData, jsonData ?? []);
    return Right(
      Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: null,
      ),
    );
  }
}
