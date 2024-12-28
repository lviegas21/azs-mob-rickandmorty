import 'package:equatable/equatable.dart';
import '../../../domain/entities/character_entity.dart';

abstract class CharactersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharacterEntity> characters;

  CharactersLoaded(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharactersError extends CharactersState {
  final String message;

  CharactersError(this.message);

  @override
  List<Object?> get props => [message];
}
