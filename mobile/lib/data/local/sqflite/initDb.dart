import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> initDb() async {
  Future<void> createDb(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS badges(id INTEGER PRIMARY KEY, name TEXT, description TEXT, descHash TEXT, siblings TEXT, pathIndices TEXT)',
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
    'INSERT OR REPLACE INTO badges(id, name, description, descHash, siblings, pathIndices) VALUES(1, "Primeira Confissão", "Enviou o primeiro desabafo no app", "2956029509268936429253174201009781131958288432666631076775709056837687872547", "[\'11450220009073749311715255450991170111412210374751672808160519305603773777075\',\'17795682345005901168976490424529142111895705479788195151154976829955854707422\',\'11103646364228013391741196488009387933299102733592066644067368558664913130812\',\'18837879509182806888829077402235962425120718943028752135635254464375331023545\']", "[0,0,0,0]")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(2, "Três Dias Seguidos", "Usou o app por 3 dias consecutivos")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description) VALUES(3, "Sete Dias Seguidos", "Usou o app por 7 dias consecutivos")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description, descHash, siblings, pathIndices) VALUES(4, "Desabafou 5 vezes", "Enviou 5 confissões no total", "6752692716371201020948652595992698237435189737094620974193607300003784594852", "[\'3633758264772579274837239920679853603643699735499326983172580689169632197832\',\'421251666650478583019422558988034340581060463768834437487025000486578291138\',\'11103646364228013391741196488009387933299102733592066644067368558664913130812\',\'18837879509182806888829077402235962425120718943028752135635254464375331023545\']", "[1,1,0,0]")',
  );
  await db.rawInsert(
    'INSERT OR REPLACE INTO badges(id, name, description, descHash, siblings, pathIndices) VALUES(5, "Desabafou 10 vezes", "Enviou 10 confissões no total", "10811569198680912517452439014576944398417114180242552893147678040304717725376", "[\'16940512308484763020934649037648641719268109201729254476884003988602613577978\',\'21383107128758709393306172686986303815159787133925921213783272186025740800413\',\'9201253154562310530004388200344717887081401939358814143296734914103522944981\',\'18837879509182806888829077402235962425120718943028752135635254464375331023545\']", "[0,0,1,0]")',
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
