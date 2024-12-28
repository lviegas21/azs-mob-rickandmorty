// ignore_for_file: non_constant_identifier_names

import '../../domain/entities/entities.dart';

class EpisodioModel {
  final String? name;
  final String? air_date;
  final String? episode;
  final String? id;
  final List<String>? characters;

  EpisodioModel({
    required this.name,
    required this.air_date,
    required this.episode,
    this.id,
    this.characters,
  });

  factory EpisodioModel.fromJson(Map json) {
    return EpisodioModel(
      name: json['name'],
      air_date: json['air_date'],
      episode: json['episode'],
      id: json['id'].toString(),
      characters: json['characters'] != null 
          ? List<String>.from(json['characters'])
          : null,
    );
  }

  EpisodioEntity toEntity() => EpisodioEntity(
        name: name,
        air_date: air_date,
        episode: episode,
        id: id,
        characters: characters,
      );
}
