// ignore_for_file: file_names, unused_import, prefer_const_constructors, avoid_print, avoid_unnecessary_containers, unused_label

import 'dart:async';
import 'dart:convert';

import 'package:desafio/pages/episodio_favorito/episodio_favorito.dart';
import 'package:desafio/pages/pesquisar_episodio/pesquisar_episodio.dart';
import 'package:desafio/pages/episodios_vistos/episodios_vistos.dart';
import 'package:desafio/pages/episodio/episodio.dart';
import 'package:desafio/model/model_episodios/episodio_model.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentindexatual = 0;
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Episodio(resultado),
      Vistos(resultado),
      Favoritos(resultado),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('RickFlix'),
        actions: [
          IconButton(
            onPressed: () async {
              String? valor =
                  await showSearch(context: context, delegate: Pesquisa());
              setState(() {
                resultado = valor!;
              });
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: telas[_currentindexatual],
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        currentIndex: _currentindexatual,
        onTap: (indice) {
          setState(() {
            _currentindexatual = indice;
          });
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            label: 'EPISODIOS',
            icon: Icon(Icons.video_file),
          ),
          BottomNavigationBarItem(
            label: 'VISTOS',
            icon: Icon(Icons.visibility_sharp),
          ),
          BottomNavigationBarItem(
            label: 'FAVORITOS',
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
