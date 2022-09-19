// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert';

class Modep {
  String name;
  String air_date;
  String episode;
  int favorito;

  Modep({
    required this.name,
    required this.air_date,
    required this.episode,
    required this.favorito,
  });

  set id(int id) {}

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'air_date': air_date,
      'episode': episode,
      'favorito': favorito,
    };
  }

  factory Modep.fromJson(Map<String, dynamic> json) {
    return Modep(
      name: json['name'],
      air_date: json["air_date"],
      episode: json['episode'],
      favorito: 0,
    );
  }
}
