// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, unused_import, dead_code, avoid_print

import 'package:desafio/providers/bd_episodio.dart';
import 'package:desafio/model/bd_model.dart';
import 'package:desafio/model/episodio_model.dart';
import 'package:flutter/material.dart';

class Vistos extends StatefulWidget {
  String pesquisa;
  Vistos(this.pesquisa);

  @override
  State<Vistos> createState() => _VistosState();
}

bd_episodio bd = bd_episodio();

class _VistosState extends State<Vistos> {
  _listavistos() {
    return bd.listaTudo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _listavistos(),
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
                    List<dynamic> episodios = snapshot.data!;
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
                                      ? (eps.favorito == 0
                                          ? Icon(Icons.favorite_border_outlined)
                                          : Icon(Icons.favorite))
                                      : null)
                                  : (eps.favorito == 0
                                      ? Icon(Icons.favorite_border_outlined)
                                      : Icon(Icons.favorite)),
                              onPressed: () async {
                                print(eps.favorito);

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
