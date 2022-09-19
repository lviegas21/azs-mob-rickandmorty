// ignore_for_file: unused_import, non_constant_identifier_names, file_names, constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'package:desafio/model/model_episodios/episodio_model.dart';
import 'package:desafio/pages/episodio/episodio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class Api {
  Future<List<Modep>> episodio_al() async {
    http.Response response =
        await http.get(Uri.parse("https://rickandmortyapi.com/api/episode"));

    Map<String, dynamic> dadosJson = json.decode(response.body);
    List<Modep> videos = dadosJson["results"].map<Modep>((map) {
      return Modep.fromJson(map);
    }).toList();
    return videos;
  }
}
