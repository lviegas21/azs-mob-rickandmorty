// ignore_for_file: non_constant_identifier_names, annotate_overrides

import 'package:equatable/equatable.dart';

class EpisodioEntity extends Equatable {
  final String? name;
  final String? air_date;
  final String? episode;
  final String? id;
  final List<String>? characters;
  final bool isWatched;

  const EpisodioEntity({
    required this.name,
    required this.air_date,
    required this.episode,
    this.id,
    this.characters,
    this.isWatched = false,
  });

  List get props => [name, air_date, episode, id, characters, isWatched];
}
