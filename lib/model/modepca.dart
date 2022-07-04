// ignore_for_file: unused_import, file_names

import 'dart:convert';

class Modepca {
  String image;
  String name;
  String status;
  String specie;

  Modepca({
    required this.image,
    required this.name,
    required this.status,
    required this.specie,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'status': status,
      'specie': specie,
    };
  }

  factory Modepca.fromJson(Map<String, dynamic> json) {
    return Modepca(
        image: json['image'],
        name: json['name'],
        status: json['status'],
        specie: json['species']);
  }
}
