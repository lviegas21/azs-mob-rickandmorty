import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/episode_model.dart';

abstract class RickMortyLocalDataSource {
  Future<bool> toggleEpisodeWatchedStatus(EpisodeModel episode);
  Future<bool> isEpisodeWatched(String episodeId);
}

class RickMortyLocalDataSourceImpl implements RickMortyLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('rick_morty.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE watched_episodes(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        air_date TEXT,
        episode TEXT,
        watched_date TEXT
      )
    ''');
  }

  @override
  Future<bool> toggleEpisodeWatchedStatus(EpisodeModel episode) async {
    try {
      final db = await database;
      final isWatched = await this.isEpisodeWatched(episode.id!);

      if (isWatched) {
        // Remove from watched episodes
        await db.delete(
          'watched_episodes',
          where: 'id = ?',
          whereArgs: [episode.id],
        );
        return false; // Return false to indicate episode is now unwatched
      } else {
        // Add to watched episodes
        final now = DateTime.now().toIso8601String();
        await db.insert(
          'watched_episodes',
          {
            'id': episode.id,
            'name': episode.name,
            'air_date': episode.airDate,
            'episode': episode.episode,
            'watched_date': now,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        return true; // Return true to indicate episode is now watched
      }
    } catch (e) {
      print('Error toggling episode status: $e');
      return false;
    }
  }

  @override
  Future<bool> isEpisodeWatched(String episodeId) async {
    final db = await database;
    final result = await db.query(
      'watched_episodes',
      where: 'id = ?',
      whereArgs: [episodeId],
    );
    return result.isNotEmpty;
  }
}
