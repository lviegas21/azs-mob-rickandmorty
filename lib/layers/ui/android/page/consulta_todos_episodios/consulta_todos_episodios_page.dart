// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/database/database_helper.dart';
import '../../../../domain/entities/episodio_entity.dart';

import '../episode_details/episode_details_page.dart';
import 'consulta_todos_episodios_presenter.dart';

class ConsultaTodosEpidiosPage extends StatelessWidget {
  final ConsultaTodosEpisodiosPresenter presenter;

  const ConsultaTodosEpidiosPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Episodes'),
        elevation: 0,
      ),
      body: Obx(
        () => presenter.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: presenter.episodioEntity.value?.length ?? 0,
                itemBuilder: (context, index) {
                  EpisodioEntity episodio =
                      presenter.episodioEntity.value![index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        episodio.name ?? 'N/A',
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
                            'Episode: ${episodio.episode ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Air Date: ${episodio.air_date ?? 'N/A'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          FutureBuilder<bool>(
                            future: DatabaseHelper.instance
                                .isEpisodeWatched(episodio.id ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data == true) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.visibility,
                                          color: Colors.green, size: 16),
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
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EpisodeDetailsPage(episode: episodio),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
