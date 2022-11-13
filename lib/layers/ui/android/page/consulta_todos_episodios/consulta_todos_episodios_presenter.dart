import 'package:get/get.dart';

import '../../../../domain/entities/entities.dart';

abstract class ConsultaTodosEpisodiosPresenter {
  Rxn<List<EpisodioEntity>?> get episodioEntity;
  RxBool get isLoading;

  Future<void> loadEpisodio();
}
