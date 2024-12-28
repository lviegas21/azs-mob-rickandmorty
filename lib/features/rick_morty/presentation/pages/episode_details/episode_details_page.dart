import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/episode_entity.dart';
import '../../../domain/entities/character_entity.dart';
import '../../bloc/characters/characters_bloc.dart';
import '../../bloc/characters/characters_event.dart';
import '../../bloc/characters/characters_state.dart';
import '../../bloc/episodes/episodes_bloc.dart';
import '../../bloc/episodes/episodes_event.dart';
import '../../bloc/episodes/episodes_state.dart';

class EpisodeDetailsPage extends StatelessWidget {
  final EpisodeEntity episode;

  const EpisodeDetailsPage({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodesBloc, EpisodesState>(
      builder: (context, episodesState) {
        // Encontra o episódio atualizado no estado do EpisodesBloc
        late final EpisodeEntity currentEpisode;
        if (episodesState is EpisodesLoaded) {
          final foundEpisode = episodesState.episodes
              .where((e) => e.id == episode.id)
              .firstOrNull;
          currentEpisode = foundEpisode ?? episode;
        } else {
          currentEpisode = episode;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(currentEpisode.name!),
            actions: [
              IconButton(
                icon: Icon(
                  currentEpisode.isWatched
                      ? Icons.visibility
                      : Icons.visibility_outlined,
                  color: currentEpisode.isWatched ? Colors.green : null,
                ),
                onPressed: () {
                  context.read<EpisodesBloc>().add(
                        MarkEpisodeAsWatchedEvent(currentEpisode),
                      );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Air Date: ${currentEpisode.airDate}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Episode: ${currentEpisode.episode}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Characters:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CharactersBloc, CharactersState>(
                  builder: (context, state) {
                    if (state is CharactersInitial) {
                      context.read<CharactersBloc>().add(
                            GetEpisodeCharactersEvent(
                                currentEpisode.characters!),
                          );
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CharactersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CharactersLoaded) {
                      return _buildCharactersList(state.characters);
                    } else if (state is CharactersError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCharactersList(List<CharacterEntity> characters) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: character.image != null
                    ? Image.network(
                        character.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : const Center(
                        child: Icon(Icons.person, size: 50),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name ?? 'Unknown',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: character.status?.toLowerCase() == 'alive'
                                ? Colors.green
                                : character.status?.toLowerCase() == 'dead'
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${character.status} - ${character.species}',
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
