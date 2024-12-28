import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/episode_entity.dart';
import '../entities/character_entity.dart';

abstract class EpisodesRepository {
  Future<Either<Failure, List<EpisodeEntity>>> getAllEpisodes();
  Future<Either<Failure, List<CharacterEntity>>> getEpisodeCharacters(List<String> characterUrls);
  Future<Either<Failure, EpisodeEntity>> toggleEpisodeWatchedStatus(EpisodeEntity episode);
  Future<Either<Failure, bool>> isEpisodeWatched(String episodeId);
}
