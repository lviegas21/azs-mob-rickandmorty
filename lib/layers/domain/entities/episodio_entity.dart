// ignore_for_file: non_constant_identifier_names, annotate_overrides

import 'package:equatable/equatable.dart';

class EpisodioEntity extends Equatable {
  final String? name;
  final String? air_date;
  final String? episode;

  const EpisodioEntity({
    this.name,
    this.air_date,
    this.episode,
  });

  List get props => [name, air_date, episode];
}
