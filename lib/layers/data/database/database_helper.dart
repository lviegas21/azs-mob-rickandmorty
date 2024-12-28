import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('episodes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE watched_episodes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        episode_id TEXT NOT NULL,
        name TEXT NOT NULL,
        air_date TEXT,
        episode_number TEXT,
        watched INTEGER NOT NULL DEFAULT 0,
        watched_date TEXT
      )
    ''');
  }

  Future<int> markEpisodeAsWatched(String episodeId, String name, String airDate, String episodeNumber) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    final data = {
      'episode_id': episodeId,
      'name': name,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'watched': 1,
      'watched_date': now,
    };

    // Try to update if exists, insert if doesn't
    final existingId = await db.query(
      'watched_episodes',
      where: 'episode_id = ?',
      whereArgs: [episodeId],
    );

    if (existingId.isEmpty) {
      return await db.insert('watched_episodes', data);
    } else {
      return await db.update(
        'watched_episodes',
        data,
        where: 'episode_id = ?',
        whereArgs: [episodeId],
      );
    }
  }

  Future<bool> isEpisodeWatched(String episodeId) async {
    final db = await database;
    final result = await db.query(
      'watched_episodes',
      where: 'episode_id = ? AND watched = 1',
      whereArgs: [episodeId],
    );
    return result.isNotEmpty;
  }
}
