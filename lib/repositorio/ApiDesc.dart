// ignore_for_file: unused_import, non_constant_identifier_names, file_names, constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable

import 'package:desafio/model/modepca.dart';
import 'package:desafio/model/episodio_model.dart';
import 'package:desafio/pages/Episodios.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const URL_BASE = "";

class ApiDesc {
  Future<List<Modepca>> descricao(int url) async {
    List<Modepca> valores = [];
    http.Response response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/episode'));
    var dadosJson = json.decode(response.body);

    var desc;
    //print(url);
    for (var dat in dadosJson['results'][url]['characters']) {
      //print(dat);
      http.Response responsedes = await http.get(Uri.parse(dat));
      var responseMap = jsonDecode(responsedes.body);

      valores.add(
        Modepca(
          image: responseMap['image'],
          name: responseMap['name'],
          status: responseMap['status'],
          specie: responseMap['species'],
        ),
      );
    }
    return valores;
  }
}




  // final dat = dadosJson['results'][0]['characters'][0];
    // http.Response responsedes = await http.get(Uri.parse(dat));
    // var responseMap = jsonDecode(responsedes.body);