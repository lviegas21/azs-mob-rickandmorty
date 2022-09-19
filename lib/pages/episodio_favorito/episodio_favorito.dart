// ignore_for_file: file_names, avoid_unnecessary_containers, unused_import, prefer_const_constructors, duplicate_ignore, dead_code, avoid_print, must_be_immutable, use_key_in_widget_constructors

import 'package:desafio/providers/banco_de_dados_episodio/banco_de_dados_episodio.dart';
import 'package:desafio/model/banco_model/banco_model.dart';
import 'package:flutter/material.dart';

class Favoritos extends StatefulWidget {
  String pesquisa;
  Favoritos(this.pesquisa);

  @override
  State<Favoritos> createState() => _FavoritosState();
}

bd_episodio bd = bd_episodio();

class _FavoritosState extends State<Favoritos> {
  _listafavoritos() {
    return bd.listaTudofav();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _listafavoritos(),
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            // ignore: prefer_const_constructors
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    List episodios = snapshot.data!;
                    var eps = episodios[index];

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
                                      ? (eps.favorito == 1
                                          ? Icon(Icons.favorite)
                                          : Icon(
                                              Icons.favorite_border_outlined))
                                      : null)
                                  : (eps.favorito == 1
                                      ? Icon(Icons.favorite)
                                      : Icon(Icons.favorite_border_outlined)),
                              onPressed: () async {
                                if (eps.favorito == 0) {
                                  eps.favorito = 1;
                                } else {
                                  eps.favorito = 0;
                                }

                                await bd.atualiza(eps);
                              }),
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
