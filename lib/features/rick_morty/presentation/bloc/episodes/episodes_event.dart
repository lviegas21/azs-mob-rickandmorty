import 'package:equatable/equatable.dart';
import '../../../domain/entities/episode_entity.dart';

abstract class EpisodesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllEpisodesEvent extends EpisodesEvent {}

class MarkEpisodeAsWatchedEvent extends EpisodesEvent {
  final EpisodeEntity episode;

  MarkEpisodeAsWatchedEvent(this.episode);

  @override
  List<Object> get props => [episode];
}
