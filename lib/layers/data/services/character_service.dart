import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character_model.dart';

class CharacterService {
  static Future<CharacterModel?> getCharacterById(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return CharacterModel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching character: $e');
      return null;
    }
  }
}
