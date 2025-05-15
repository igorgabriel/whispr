import 'package:flutter/foundation.dart';

import '../models/replyAI.dart';
import '../services/how_do_you_feel_service.dart';

class HowDoYouFeelViewModel extends ChangeNotifier {
  final HowDoYouFeelService _service = HowDoYouFeelService();
  ReplyAI _replyAI = ReplyAI.copyWith(reply: '', emotion: '', risk: false);
  bool _loading = false;

  ReplyAI get replyAI => _replyAI;
  bool get loading => _loading;

  Future<void> post(String texto) async {
    _loading = true;
    notifyListeners();

    var result = await _service.post(texto);

    result.fold(
      (error) {
        _replyAI = ReplyAI.copyWith(reply: '', emotion: '', risk: false);
      },
      (response) {
        _replyAI = response.data;
      },
    );

    _loading = false;
    notifyListeners();
  }
}
