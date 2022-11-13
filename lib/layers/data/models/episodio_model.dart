import 'package:desafio/layers/domain/entities/entities.dart';

class EpisodioModel {
  final String? name;
  final String? air_date;
  final String? episode;

  EpisodioModel({
    required this.name,
    required this.air_date,
    required this.episode,
  });

  factory EpisodioModel.fromJson(Map json) {
    return EpisodioModel(
      name: json['name'],
      air_date: json['air_date'],
      episode: json['episode'],
    );
  }

  EpisodioEntity toEntity() => EpisodioEntity(
        name: name,
        air_date: air_date,
        episode: episode,
      );
}
