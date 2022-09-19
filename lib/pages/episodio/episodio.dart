// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, dead_code, must_be_immutable, use_key_in_widget_constructors, unused_local_variable, avoid_print, prefer_is_empty, file_names, unused_import

import 'package:desafio/model/model_listando_personagens/modepca.dart';
import 'package:desafio/repositorio/api_episodios/api_episodios.dart';
import 'package:desafio/pages/descricao_episodio/descricao_episodio.dart';
import 'package:desafio/providers/banco_de_dados_episodio/banco_de_dados_episodio.dart';
import 'package:desafio/model/model_episodios/episodio_model.dart';
import 'package:desafio/repositorio/api_episodios/api_listando_todos_episodios.dart';
import 'package:flutter/material.dart';

class Episodio extends StatefulWidget {
  String pesquisa;
  Episodio(this.pesquisa);

  @override
  State<Episodio> createState() => _EpisodioState();
}

class _EpisodioState extends State<Episodio> {
  bd_episodio bd = bd_episodio();
  int inicio_page = 1;
  int fim_page = 3;
  _listaepisodio() {
    Api api = Api();
    return api.episodio_al();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Modep>>(
      future: _listaepisodio(),
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
              return ListView.separated(
                  itemBuilder: (context, index) {
                    List<Modep> episodios = snapshot.data!;
                    Modep eps = episodios[index];

                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(widget.pesquisa != ''
                              ? (widget.pesquisa == eps.name ? eps.name : '')
                              : eps.name),
                          subtitle: Text(widget.pesquisa != ''
                              ? (widget.pesquisa == eps.name ? eps.episode : '')
                              : eps.episode),
                          leading: Text(widget.pesquisa != ''
                              ? (widget.pesquisa == eps.name
                                  ? eps.air_date
                                  : '')
                              : eps.air_date),
                          trailing: MaterialButton(
                            child: widget.pesquisa != ''
                                ? (widget.pesquisa == eps.name
                                    ? Icon(Icons.visibility)
                                    : null)
                                : Icon(Icons.visibility),
                            onPressed: () async {
                              print('inserindo');
                              final valor = await bd.listaUm(eps);
                              if (valor.length == 0) {
                                await bd.insere(eps);
                              }

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Descricao(index,
                                      eps.name, eps.air_date, eps.episode)));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data!.length);
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}
