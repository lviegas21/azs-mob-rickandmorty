import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/character_entity.dart';
import '../repositories/episodes_repository.dart';

class GetEpisodeCharacters implements UseCase<List<CharacterEntity>, CharacterParams> {
  final EpisodesRepository repository;

  GetEpisodeCharacters(this.repository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(CharacterParams params) async {
    return await repository.getEpisodeCharacters(params.characterUrls);
  }
}

class CharacterParams extends Equatable {
  final List<String> characterUrls;

  const CharacterParams({required this.characterUrls});

  @override
  List<Object> get props => [characterUrls];
}
