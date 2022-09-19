// ignore_for_file: camel_case_types, unused_local_variable

import 'package:desafio/model/banco_model/banco_model.dart';
import 'package:desafio/model/model_episodios/episodio_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class bd_episodio {
  Database? _db;

  Future<Database> get db async {
    return _db ?? await iniciarBanco();
  }

  Future<Database> iniciarBanco() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "bd_episode.db");
    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE vistos( "
        "id integer primary key, "
        "air_date text, "
        "episode text, "
        "name text, "
        "favorito integer)",
      );
    });
  }

  Future<Modep> insere(item) async {
    Database database = await db;
    item.id = await database.insert('vistos', item.toMap());
    return item;
  }

  Future<int> atualiza(item) async {
    Database database = await db;
    return await database.update(
      'vistos',
      item.toMap(),
      where: 'name = ?',
      whereArgs: [item.name],
    );
  }

  Future<int> deleta(Modep item) async {
    Database database = await db;
    return await database.delete(
      "vistos",
      where: "name = ?",
      whereArgs: [item.name],
    );
  }

  Future<List> listaUm(item) async {
    Database database = await db;
    List listaDeMap = await database
        .rawQuery('SELECT * FROM vistos WHERE name=?', [item.name]);
    List listaumep = listaDeMap.map((map) => Modep.fromJson(map)).toList();

    return listaDeMap;
  }

  Future<List> listaTudo() async {
    Database database = await db;
    List listaDeMaps = await database.rawQuery("select * from vistos");
    List listaeps = listaDeMaps.map((map) => Banco.fromMap(map)).toList();

    return listaeps;
  }

  Future<List> listaTudofav() async {
    Database database = await db;
    List listaDeMaps =
        await database.rawQuery("select * from vistos WHERE favorito = ?", [1]);
    List listaeps = listaDeMaps.map((map) => Banco.fromMap(map)).toList();

    return listaeps;
  }
}
