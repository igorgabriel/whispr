import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

    await verifyBadges();

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

  Future<void> verifyBadges() async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(join(dbPath, 'whispr-db.db'));

    var numberDesabafos = (await db.query('desabafos')).length;

    var data = {};

    if (numberDesabafos == 1) {
      var badge = await (db.query('badges', where: 'id = ?', whereArgs: [1]));
      data['badgeId'] = badge[0]['id'];
      data['descHash'] = badge[0]['descHash'];
      data['siblings'] = badge[0]['siblings'];
      data['pathIndices'] = badge[0]['pathIndices'];
    }

    if (numberDesabafos == 5) {
      var badge = await (db.query('badges', where: 'id = ?', whereArgs: [4]));
      data['badgeId'] = badge[0]['id'];
      data['descHash'] = badge[0]['descHash'];
      data['siblings'] = badge[0]['siblings'];
      data['pathIndices'] = badge[0]['pathIndices'];
    }

    if (numberDesabafos == 10) {
      var badge = await (db.query('badges', where: 'id = ?', whereArgs: [5]));
      data['badgeId'] = badge[0]['id'];
      data['descHash'] = badge[0]['descHash'];
      data['siblings'] = badge[0]['siblings'];
      data['pathIndices'] = badge[0]['pathIndices'];
    }
  }
}
