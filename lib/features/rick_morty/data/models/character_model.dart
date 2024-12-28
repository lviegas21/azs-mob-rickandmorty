import '../../domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    String? id,
    String? name,
    String? status,
    String? species,
    String? image,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          image: image,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'].toString(),
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'image': image,
    };
  }
}
