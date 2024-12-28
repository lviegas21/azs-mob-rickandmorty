import 'package:equatable/equatable.dart';
import '../../../domain/entities/episode_entity.dart';

abstract class EpisodesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EpisodesInitial extends EpisodesState {}

class EpisodesLoading extends EpisodesState {}

class EpisodesLoaded extends EpisodesState {
  final List<EpisodeEntity> episodes;

  EpisodesLoaded(this.episodes);

  @override
  List<Object?> get props => [episodes];
}

class EpisodesError extends EpisodesState {
  final String message;

  EpisodesError(this.message);

  @override
  List<Object?> get props => [message];
}

class EpisodeWatchedSuccess extends EpisodesState {
  final EpisodeEntity episode;

  EpisodeWatchedSuccess(this.episode);

  @override
  List<Object?> get props => [episode];
}

class EpisodeWatchedError extends EpisodesState {
  final String message;

  EpisodeWatchedError(this.message);

  @override
  List<Object?> get props => [message];
}
