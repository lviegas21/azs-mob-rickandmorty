// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, dead_code, avoid_unnecessary_containers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:desafio/repositorio/api_episodios/api_listando_todos_episodios.dart';
import 'package:desafio/model/model_listando_personagens/modepca.dart';
import 'package:flutter/material.dart';

class Descricao extends StatefulWidget {
  int des;
  String name;
  String data;
  String episodio;
  Descricao(this.des, this.name, this.data, this.episodio);

  @override
  State<Descricao> createState() => _DescricaoState();
}

class _DescricaoState extends State<Descricao> {
  ApiDesc api = ApiDesc();
  _listaDes() {
    return api.descricao(widget.des);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RickFlix'),
      ),
      body: Column(
        children: [
          Container(
            child: ListTile(
              title: Text('Nome: ${widget.name}'),
              subtitle: Text('Temporada: ${widget.episodio}'),
              trailing: Text('Data: ${widget.data}'),
            ),
          ),
          FutureBuilder<List<Modepca>>(
            future: _listaDes(),
            builder: (contex, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    List<Modepca>? descricao = snapshot.data;

                    return descricao != null && descricao.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: descricao.length,
                              itemBuilder: (_, i) {
                                return ListTile(
                                  title: Text(descricao[i].name),
                                  subtitle: Text(descricao[i].specie),
                                  leading: Image.network(descricao[i].image),
                                  trailing: Text(descricao[i].status),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Text('Nenhum valor encontrado'),
                          );
                  } else {
                    return Center(
                      child: Text("Nenhum dado a ser exibido!"),
                    );
                  }
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
