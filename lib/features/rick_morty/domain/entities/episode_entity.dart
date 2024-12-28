import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? airDate;
  final String? episode;
  final List<String>? characters;
  final bool isWatched;

  const EpisodeEntity({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.isWatched = false,
  });

  @override
  List<Object?> get props => [id, name, airDate, episode, characters, isWatched];
}
