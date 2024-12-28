import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/rick_morty/data/datasources/rick_morty_local_datasource.dart';
import 'features/rick_morty/data/datasources/rick_morty_remote_datasource.dart';
import 'features/rick_morty/data/repositories/episodes_repository_impl.dart';
import 'features/rick_morty/domain/repositories/episodes_repository.dart';
import 'features/rick_morty/domain/usecases/get_all_episodes.dart';
import 'features/rick_morty/domain/usecases/get_episode_characters.dart';
import 'features/rick_morty/domain/usecases/mark_episode_as_watched.dart';
import 'features/rick_morty/presentation/bloc/episodes/episodes_bloc.dart';
import 'features/rick_morty/presentation/bloc/characters/characters_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => EpisodesBloc(
      getAllEpisodes: sl(),
      toggleEpisodeWatched: sl(),
    ),
  );
  sl.registerFactory(
    () => CharactersBloc(getEpisodeCharacters: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllEpisodes(sl()));
  sl.registerLazySingleton(() => GetEpisodeCharacters(sl()));
  sl.registerLazySingleton(() => ToggleEpisodeWatched(sl()));

  // Repository
  sl.registerLazySingleton<EpisodesRepository>(
    () => EpisodesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RickMortyRemoteDataSource>(
    () => RickMortyRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<RickMortyLocalDataSource>(
    () => RickMortyLocalDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
