import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_episode_characters.dart';
import 'characters_event.dart';
import 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetEpisodeCharacters getEpisodeCharacters;

  CharactersBloc({required this.getEpisodeCharacters})
      : super(CharactersInitial()) {
    on<GetEpisodeCharactersEvent>(_onGetEpisodeCharacters);
  }

  Future<void> _onGetEpisodeCharacters(
    GetEpisodeCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    final result = await getEpisodeCharacters(
      CharacterParams(characterUrls: event.characterUrls),
    );
    result.fold(
      (failure) => emit(CharactersError('Failed to load characters')),
      (characters) => emit(CharactersLoaded(characters)),
    );
  }
}
