import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/episode_entity.dart';
import '../repositories/episodes_repository.dart';

class ToggleEpisodeWatched implements UseCase<EpisodeEntity, ToggleEpisodeParams> {
  final EpisodesRepository repository;

  ToggleEpisodeWatched(this.repository);

  @override
  Future<Either<Failure, EpisodeEntity>> call(ToggleEpisodeParams params) async {
    return await repository.toggleEpisodeWatchedStatus(params.episode);
  }
}

class ToggleEpisodeParams extends Equatable {
  final EpisodeEntity episode;

  const ToggleEpisodeParams({required this.episode});

  @override
  List<Object> get props => [episode];
}
