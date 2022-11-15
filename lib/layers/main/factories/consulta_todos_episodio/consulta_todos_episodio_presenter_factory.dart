import 'package:desafio/layers/presentation/presenter/getx_consulta_todos_episodios_presenter.dart';
import 'package:desafio/layers/ui/android/page/consulta_todos_episodios/consulta_todos_episodios_presenter.dart';

import '../usecase/load_consulta_episodio.dart';

ConsultaTodosEpisodiosPresenter makeConsultaEpisodioPresenter() =>
    GetxConsultaTodosEpisodiosPresenter(episodioUsecase: makeRemoteEpisodio());
