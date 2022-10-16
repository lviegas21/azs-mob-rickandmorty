import 'package:desafio/layers/domain/entities/entities.dart';

abstract class EpisodioUsecase {
  Future<List<EpisodioEntity>?> getEpisodio();
}
