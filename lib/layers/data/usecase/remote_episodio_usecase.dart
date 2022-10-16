// ignore_for_file: body_might_complete_normally_nullable

import 'package:desafio/layers/data/http/http_client.dart';
import 'package:desafio/layers/data/models/episodio_model.dart';
import 'package:desafio/layers/domain/entities/entities.dart';
import 'package:desafio/layers/domain/helpers/domain_error.dart';
import 'package:desafio/layers/domain/usecase/usecase.dart';

import '../http/http.dart';

class RemoteEpisodioUsecase implements EpisodioUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteEpisodioUsecase(this.httpClient, this.url);

  @override
  Future<List<EpisodioEntity>?> getEpisodio() async {
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return response.map<EpisodioEntity>(
          (json) => EpisodioModel.fromJson(json).toEntity());
    } on HttpError catch (error) {
      error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
