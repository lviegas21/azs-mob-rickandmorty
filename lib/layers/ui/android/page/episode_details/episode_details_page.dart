import 'package:flutter/material.dart';
import '../../../../data/database/database_helper.dart';
import '../../../../data/models/character_model.dart';
import '../../../../data/services/character_service.dart';
import '../../../../domain/entities/episodio_entity.dart';

class EpisodeDetailsPage extends StatefulWidget {
  final EpisodioEntity episode;

  const EpisodeDetailsPage({Key? key, required this.episode}) : super(key: key);

  @override
  State<EpisodeDetailsPage> createState() => _EpisodeDetailsPageState();
}

class _EpisodeDetailsPageState extends State<EpisodeDetailsPage> {
  List<CharacterModel> characters = [];
  bool isLoading = true;
  bool isWatched = false;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
    _checkWatchStatus();
  }

  Future<void> _checkWatchStatus() async {
    if (widget.episode.id != null) {
      final watched =
          await DatabaseHelper.instance.isEpisodeWatched(widget.episode.id!);
      setState(() {
        isWatched = watched;
      });
    }
  }

  Future<void> _loadCharacters() async {
    if (widget.episode.characters == null) return;

    List<CharacterModel> loadedCharacters = [];
    for (String url in widget.episode.characters!) {
      final character = await CharacterService.getCharacterById(url);
      if (character != null) {
        loadedCharacters.add(character);
      }
    }

    setState(() {
      characters = loadedCharacters;
      isLoading = false;
    });
  }

  Future<void> _toggleWatchStatus() async {
    if (widget.episode.id == null) return;

    await DatabaseHelper.instance.markEpisodeAsWatched(
      widget.episode.id!,
      widget.episode.name ?? '',
      widget.episode.air_date ?? '',
      widget.episode.episode ?? '',
    );

    setState(() {
      isWatched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episode.name ?? 'Episode Details'),
        actions: [
          IconButton(
            icon: Icon(
              isWatched ? Icons.visibility : Icons.visibility_outlined,
              color: isWatched ? Colors.green : null,
            ),
            onPressed: _toggleWatchStatus,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Episode: ${widget.episode.episode}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Air Date: ${widget.episode.air_date}',
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
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                          color:
                                              character.status?.toLowerCase() ==
                                                      'alive'
                                                  ? Colors.green
                                                  : character.status
                                                              ?.toLowerCase() ==
                                                          'dead'
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
                  ),
          ),
        ],
      ),
    );
  }
}
