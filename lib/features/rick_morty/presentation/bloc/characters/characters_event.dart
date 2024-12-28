import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEpisodeCharactersEvent extends CharactersEvent {
  final List<String> characterUrls;

  GetEpisodeCharactersEvent(this.characterUrls);

  @override
  List<Object> get props => [characterUrls];
}
