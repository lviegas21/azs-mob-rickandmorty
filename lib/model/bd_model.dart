// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

List<Banco> bancoFromJson(String str) =>
    List<Banco>.from(json.decode(str).map((x) => Banco.fromMap(x)));

String bancoToJson(List<Banco> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Banco {
  String name;
  String air_date;
  String episode;
  int favorito;

  Banco({
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
      'favorito': favorito
    };
  }

  factory Banco.fromMap(Map<String, dynamic> json) {
    return Banco(
        name: json['name'],
        air_date: json['air_date'],
        episode: json['episode'],
        favorito: json['favorito']);
  }
}
