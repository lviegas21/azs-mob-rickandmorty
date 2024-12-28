import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/episode_entity.dart';
import '../repositories/episodes_repository.dart';

class GetAllEpisodes implements UseCase<List<EpisodeEntity>, NoParams> {
  final EpisodesRepository repository;

  GetAllEpisodes(this.repository);

  @override
  Future<Either<Failure, List<EpisodeEntity>>> call(NoParams params) async {
    return await repository.getAllEpisodes();
  }
}
