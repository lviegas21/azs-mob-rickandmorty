import '../../domain/entities/episode_entity.dart';

class EpisodeModel extends EpisodeEntity {
  const EpisodeModel({
    String? id,
    String? name,
    String? airDate,
    String? episode,
    List<String>? characters,
    bool isWatched = false,
  }) : super(
          id: id,
          name: name,
          airDate: airDate,
          episode: episode,
          characters: characters,
          isWatched: isWatched,
        );

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'].toString(),
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
      characters: json['characters'] != null
          ? List<String>.from(json['characters'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'air_date': airDate,
      'episode': episode,
    };
  }
}
