// ignore_for_file: annotate_overrides, avoid_print

import 'package:desafio/layers/domain/entities/episodio_entity.dart';
import 'package:desafio/layers/ui/android/page/consulta_todos_episodios/consulta_todos_episodios.dart';

import 'package:get/get.dart';

import '../../domain/usecase/usecase.dart';

class GetxConsultaTodosEpisodiosPresenter extends GetxController
    implements ConsultaTodosEpisodiosPresenter {
  final EpisodioUsecase episodioUsecase;

  var isLoading = false.obs;

  Rxn<List<EpisodioEntity>> episodioEntity = Rxn<List<EpisodioEntity>>();

  GetxConsultaTodosEpisodiosPresenter({required this.episodioUsecase});

  @override
  Future<void> loadEpisodio() async {
    try {
      isLoading.value = true;
      episodioEntity.value = await episodioUsecase.getEpisodio();
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  void onInit() {
    super.onInit();
    loadEpisodio();
  }
}
