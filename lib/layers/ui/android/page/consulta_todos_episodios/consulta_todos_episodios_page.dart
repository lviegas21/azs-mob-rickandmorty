// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, unrelated_type_equality_checks

import 'package:desafio/layers/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desafio/layers/ui/android/page/consulta_todos_episodios/consulta_todos_episodios_presenter.dart';

class ConsultaTodosEpidiosPage extends StatelessWidget {
  final ConsultaTodosEpisodiosPresenter presenter;
  const ConsultaTodosEpidiosPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        body: presenter.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: ListView.builder(
                    itemCount: presenter.episodioEntity.value?.length,
                    itemBuilder: (context, index) {
                      EpisodioEntity episodio =
                          presenter.episodioEntity.value![index];
                      return ListTile(
                        title: Text(episodio.name ?? "N/I"),
                        subtitle: Text(episodio.episode ?? "N/I"),
                      );
                    }),
              ),
      ),
    );
  }
}
