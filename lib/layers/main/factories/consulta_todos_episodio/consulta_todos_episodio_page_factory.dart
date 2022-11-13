import 'package:desafio/layers/main/factories/consulta_todos_episodio/consulta_todos_episodio.dart';
import 'package:desafio/layers/ui/android/page/consulta_todos_episodios/consulta_todos_episodios_page.dart';
import 'package:desafio/layers/ui/android/page/consulta_todos_episodios/consulta_todos_episodios_presenter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget makeConsultaEpisodioPage() {
  final presenter =
      Get.put<ConsultaTodosEpisodiosPresenter>(makeConsultaEpisodioPresenter());
  return ConsultaTodosEpidiosPage(presenter: presenter);
}
