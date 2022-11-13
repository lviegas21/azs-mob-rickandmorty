// ignore_for_file: body_might_complete_normally_nullable, unnecessary_import

import 'package:desafio/layers/data/http/http_client.dart';
import 'package:desafio/layers/data/models/episodio_model.dart';
import 'package:desafio/layers/domain/entities/entities.dart';
import 'package:desafio/layers/domain/helpers/domain_error.dart';
import 'package:desafio/layers/domain/usecase/usecase.dart';

import '../http/http.dart';

class RemoteEpisodioUsecase implements EpisodioUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteEpisodioUsecase({required this.httpClient, required this.url});

  @override
  Future<List<EpisodioEntity>?> getEpisodio() async {
    try {
      final response = await httpClient.request(
          url: url, method: 'get', path: '/api/episode');
      print(response["results"][0]);
      return response["results"]
          .map<EpisodioEntity>((map) => EpisodioModel.fromJson(map).toEntity())
          .toList();
    } on HttpError catch (error) {
      error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
