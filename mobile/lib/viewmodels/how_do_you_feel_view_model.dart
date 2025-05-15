import 'package:flutter/foundation.dart';

import '../services/how_do_you_feel_service.dart';

class HomeViewModel extends ChangeNotifier {
  final HowDoYouFeelService _service = HowDoYouFeelService();
  // List<Empresa> _empresas = [];
  bool _loading = false;

  // List<Empresa> get empresas => _empresas;
  bool get loading => _loading;

  Future<void> fetchEmpresas(
    String chave,
    double? latitude,
    double? longitude,
    int offset,
  ) async {
    if (offset == 0) _loading = true;
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });

    final result = await _service.fetch();
    result.fold(
      (error) {
        // _empresas = [];
      },
      (response) {
        // for (var empresa in response.results) {
        //   _empresas.add(Empresa.fromJson(empresa));
        // }
      },
    );

    _loading = false;
    notifyListeners();
  }
}
