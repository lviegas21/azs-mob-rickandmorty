class CharacterModel {
  final String? id;
  final String? name;
  final String? status;
  final String? species;
  final String? image;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'].toString(),
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
    );
  }
}
