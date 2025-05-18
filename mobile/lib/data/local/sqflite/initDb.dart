import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> initDb() async {
  Future<void> createDb(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS badges(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS desabafos(id INTEGER PRIMARY KEY, timestamp TEXT, text TEXT, ia_answer TEXT)',
    );
  }

  //   {
  // timestamp, desabafo, ia_answer: {objeto da resposta do endpoint /confessions ({
  //   "reply": "string",
  //   "emotion": "string",
  //   "risk": true,
  //   "zk_moderation_proof": "string"
  // } }

  final dbPath = await getDatabasesPath();
  final db = await openDatabase(
    join(dbPath, 'whispr-db.db'),
    onOpen: (db) async {
      return await createDb(db);
    },
    version: 1,
  );

  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(1, "Primeira Confissão", "Enviou o primeiro desabafo no app")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(2, "Três Dias Seguidos", "Usou o app por 3 dias consecutivos")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(3, "Sete Dias Seguidos", "Usou o app por 7 dias consecutivos")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(4, "Desabafou 5 vezes", "Enviou 5 confissões no total")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(5, "Desabafou 10 vezes", "Enviou 10 confissões no total")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(6, "Confissão Noturna", "Enviou uma confissão entre 0h e 5h")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(7, "Consistência Semanal", "Abrir o app pelo menos 1x em 7 dias diferentes")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(8, "Texto Profundo", "Enviou uma confissão com mais de 300 caracteres")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(9, "Renasceu Calmo", "Confessou risco e depois teve uma emoção \'calma\'")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(10, "Usuário Pioneiro", "Usou o app no período de lançamento (beta)")',
  );

  db.close();
}
