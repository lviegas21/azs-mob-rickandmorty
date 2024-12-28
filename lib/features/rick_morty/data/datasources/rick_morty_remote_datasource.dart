import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/episode_model.dart';
import '../models/character_model.dart';

abstract class RickMortyRemoteDataSource {
  Future<List<EpisodeModel>> getAllEpisodes();
  Future<List<CharacterModel>> getCharacters(List<String> characterUrls);
}

class RickMortyRemoteDataSourceImpl implements RickMortyRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://rickandmortyapi.com/api';

  RickMortyRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EpisodeModel>> getAllEpisodes() async {
    final response = await client.get(Uri.parse('$baseUrl/episode'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => EpisodeModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load episodes');
    }
  }

  @override
  Future<List<CharacterModel>> getCharacters(List<String> characterUrls) async {
    List<CharacterModel> characters = [];
    
    for (String url in characterUrls) {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        characters.add(CharacterModel.fromJson(json.decode(response.body)));
      }
    }

    return characters;
  }
}
