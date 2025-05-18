import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> initDb() async {
  final dbPath = await getDatabasesPath();
  final db = await openDatabase(
    join(dbPath, 'whispr-db.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS badges(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
      );
    },
    version: 1,
  );

  await db.insert('badges', {
    'id': 1,
    'name': 'Primeira Confissão',
    'description': 'Enviou o primeiro desabafo no app',
  });
  await db.insert('badges', {
    'id': 2,
    'name': 'Três Dias Seguidos',
    'description': 'description": "Usou o app por 3 dias consecutivos',
  });
  await db.insert('badges', {
    'id': 3,
    'name': 'Sete Dias Seguidos',
    'description': 'Usou o app por 7 dias consecutivos',
  });
  await db.insert('badges', {
    'id': 4,
    'name': 'Desabafou 5 vezes',
    'description': 'Enviou 5 confissões no total',
  });
  await db.insert('badges', {
    'id': 5,
    'name': 'Desabafou 10 vezes',
    'description': 'Enviou 10 confissões no total',
  });
  await db.insert('badges', {
    'id': 6,
    'name': 'Confissão Noturna"',
    'description': 'Enviou uma confissão entre 0h e 5h',
  });
  await db.insert('badges', {
    'id': 7,
    'name': '"Consistência Semanal',
    'description': 'Abrir o app pelo menos 1x em 7 dias diferentes',
  });
  await db.insert('badges', {
    'id': 8,
    'name': 'Texto Profundo',
    'description': 'Enviou uma confissão com mais de 300 caracteres',
  });
  await db.insert('badges', {
    'id': 9,
    'name': 'Renasceu Calmo',
    'description': "Confessou risco e depois teve uma emoção 'calma'",
  });
  await db.insert('badges', {
    'id': 10,
    'name': 'Usuário Pioneiro',
    'description': 'Usou o app no período de lançamento (beta)',
  });

  db.close();
}
