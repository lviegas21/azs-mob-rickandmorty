import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/episode_entity.dart';
import '../../../domain/usecases/get_all_episodes.dart';
import '../../../domain/usecases/mark_episode_as_watched.dart';
import 'episodes_event.dart';
import 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final GetAllEpisodes getAllEpisodes;
  final ToggleEpisodeWatched toggleEpisodeWatched;

  EpisodesBloc({
    required this.getAllEpisodes,
    required this.toggleEpisodeWatched,
  }) : super(EpisodesInitial()) {
    on<GetAllEpisodesEvent>(_onGetAllEpisodes);
    on<MarkEpisodeAsWatchedEvent>(_onToggleEpisodeWatched);
  }

  Future<void> _onGetAllEpisodes(
    GetAllEpisodesEvent event,
    Emitter<EpisodesState> emit,
  ) async {
    emit(EpisodesLoading());
    final result = await getAllEpisodes(NoParams());
    result.fold(
      (failure) => emit(EpisodesError('Failed to load episodes')),
      (episodes) => emit(EpisodesLoaded(episodes)),
    );
  }

  Future<void> _onToggleEpisodeWatched(
    MarkEpisodeAsWatchedEvent event,
    Emitter<EpisodesState> emit,
  ) async {
    if (state is EpisodesLoaded) {
      final currentState = state as EpisodesLoaded;
      final result = await toggleEpisodeWatched(
        ToggleEpisodeParams(episode: event.episode),
      );

      result.fold(
        (failure) => emit(EpisodeWatchedError('Failed to update episode status')),
        (updatedEpisode) {
          final updatedEpisodes = currentState.episodes.map((episode) {
            if (episode.id == updatedEpisode.id) {
              return updatedEpisode;
            }
            return episode;
          }).toList();
          
          emit(EpisodesLoaded(updatedEpisodes));
        },
      );
    }
  }
}
