import 'package:desafio/layers/data/usecase/remote_episodio_usecase.dart';
import 'package:desafio/layers/utils/constants.dart';

import '../../http/http.dart';

RemoteEpisodioUsecase makeRemoteEpisodio() => RemoteEpisodioUsecase(
    httpClient: makeHttpAdapter(), url: makeApiUrl(url_base));
