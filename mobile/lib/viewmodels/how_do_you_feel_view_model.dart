import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/badge.dart';
import '../models/replyAI.dart';
import '../services/how_do_you_feel_service.dart';

class HowDoYouFeelViewModel extends ChangeNotifier {
  final HowDoYouFeelService _service = HowDoYouFeelService();
  ReplyAI _replyAI = ReplyAI.copyWith(reply: '', emotion: '', risk: false);
  final List<Badge> _badges = [];
  bool _loading = false;

  ReplyAI get replyAI => _replyAI;
  List<Badge> get badges => _badges;
  bool get loading => _loading;

  Future<void> post(String texto) async {
    _loading = true;
    notifyListeners();

    await verifyBadges();

    var result = await _service.post(texto, badges);

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

    if (numberDesabafos == 1) {
      var badge = await (db.query('badges', where: 'id = ?', whereArgs: [1]));

      _badges.add(
        Badge(
          id: badge[0]['id'] as int,
          text: badge[0]['name'] as String,
          // iaAnswer: badge[0]['iaAnswer'] as String,
          descHash: badge[0]['descHash'] as String,
          siblings: badge[0]['siblings'] as String,
          pathIndices: badge[0]['pathIndices'] as String,
        ),
      );
    }

    if (numberDesabafos == 5) {
      var badge = await (db.query('badges', where: 'id = ?', whereArgs: [4]));
      _badges.add(
        Badge(
          id: badge[0]['id'] as int,
          text: badge[0]['name'] as String,
          // iaAnswer: badge[0]['iaAnswer'] as String,
          descHash: badge[0]['descHash'] as String,
          siblings: badge[0]['siblings'] as String,
          pathIndices: badge[0]['pathIndices'] as String,
        ),
      );
    }

    if (numberDesabafos == 10) {
      var badge = await (db.query('badges', where: 'id = ?', whereArgs: [5]));
      _badges.add(
        Badge(
          id: badge[0]['id'] as int,
          text: badge[0]['name'] as String,
          // iaAnswer: badge[0]['iaAnswer'] as String,
          descHash: badge[0]['descHash'] as String,
          siblings: badge[0]['siblings'] as String,
          pathIndices: badge[0]['pathIndices'] as String,
        ),
      );
    }

    db.close();
  }
}
