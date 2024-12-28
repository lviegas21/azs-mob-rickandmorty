import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/episode_entity.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repositories/episodes_repository.dart';
import '../datasources/rick_morty_local_datasource.dart';
import '../datasources/rick_morty_remote_datasource.dart';
import '../models/episode_model.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  final RickMortyRemoteDataSource remoteDataSource;
  final RickMortyLocalDataSource localDataSource;

  EpisodesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getAllEpisodes() async {
    try {
      final episodes = await remoteDataSource.getAllEpisodes();
      // Check watched status for each episode
      for (var i = 0; i < episodes.length; i++) {
        final isWatched = await localDataSource.isEpisodeWatched(episodes[i].id!);
        episodes[i] = EpisodeModel(
          id: episodes[i].id,
          name: episodes[i].name,
          airDate: episodes[i].airDate,
          episode: episodes[i].episode,
          characters: episodes[i].characters,
          isWatched: isWatched,
        );
      }
      return Right(episodes);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> getEpisodeCharacters(
      List<String> characterUrls) async {
    try {
      final characters = await remoteDataSource.getCharacters(characterUrls);
      return Right(characters);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, EpisodeEntity>> toggleEpisodeWatchedStatus(
      EpisodeEntity episode) async {
    try {
      final episodeModel = EpisodeModel(
        id: episode.id,
        name: episode.name,
        airDate: episode.airDate,
        episode: episode.episode,
        characters: episode.characters,
        isWatched: episode.isWatched,
      );
      
      final isWatched = await localDataSource.toggleEpisodeWatchedStatus(episodeModel);
      
      // Return updated episode with new watched status
      return Right(EpisodeModel(
        id: episode.id,
        name: episode.name,
        airDate: episode.airDate,
        episode: episode.episode,
        characters: episode.characters,
        isWatched: isWatched,
      ));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isEpisodeWatched(String episodeId) async {
    try {
      final result = await localDataSource.isEpisodeWatched(episodeId);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
