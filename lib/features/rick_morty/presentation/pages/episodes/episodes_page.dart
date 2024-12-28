import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/episode_entity.dart';
import '../../bloc/episodes/episodes_bloc.dart';
import '../../bloc/episodes/episodes_event.dart';
import '../../bloc/episodes/episodes_state.dart';
import '../episode_details/episode_details_page.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Episodes'),
        elevation: 0,
      ),
      body: BlocBuilder<EpisodesBloc, EpisodesState>(
        builder: (context, state) {
          if (state is EpisodesInitial) {
            context.read<EpisodesBloc>().add(GetAllEpisodesEvent());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EpisodesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EpisodesError) {
            return Center(child: Text(state.message));
          }

          if (state is EpisodesLoaded) {
            return ListView.builder(
              itemCount: state.episodes.length,
              itemBuilder: (context, index) {
                final episode = state.episodes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      episode.name ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Episode: ${episode.episode ?? 'N/A'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Air Date: ${episode.airDate ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        if (episode.isWatched)
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Icon(Icons.visibility, color: Colors.green, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Watched',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EpisodeDetailsPage(episode: episode),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
