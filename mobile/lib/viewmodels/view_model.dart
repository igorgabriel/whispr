import 'package:flutter/foundation.dart';

import '../services/service.dart';

class ViewModel extends ChangeNotifier {
  final Service _service = Service();
  // List<Empresa> _empresas = [];
  // bool _loading = false;
  // bool _SmsConfirmed = false;
  // bool _codeConfirmed = false;

  // List<Empresa> get empresas => _empresas;
  // bool get loading => _loading;
  // bool get SmsConfirmed => _SmsConfirmed;
  // bool get codeConfirmed => _codeConfirmed;

  // Future<void> fetchEmpresas(
  //   String chave,
  //   double? latitude,
  //   double? longitude,
  //   int offset,
  // ) async {
  //   if (offset == 0) _loading = true;
  //   Future.delayed(Duration.zero, () async {
  //     notifyListeners();
  //   });

  //   final result = await _empresaService.fetchEmpresas(
  //     chave,
  //     latitude,
  //     longitude,
  //     offset,
  //   );
  //   result.fold(
  //     (error) {
  //       _empresas = [];
  //     },
  //     (response) {
  //       for (var empresa in response.results) {
  //         _empresas.add(Empresa.fromJson(empresa));
  //       }
  //     },
  //   );

  // _loading = false;
  // notifyListeners();
}
