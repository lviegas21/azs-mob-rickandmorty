// ignore_for_file: body_might_complete_normally_nullable, unnecessary_import

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecase/usecase.dart';
import '../http/http.dart';
import '../models/models.dart';

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
