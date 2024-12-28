import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final String? id;
  final String? name;
  final String? status;
  final String? species;
  final String? image;

  const CharacterEntity({
    this.id,
    this.name,
    this.status,
    this.species,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, status, species, image];
}
