import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/usecases/usecase.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';
class GetMoviesWithPageUsecase extends UseCase<List<Movie>,Params> {
  final MoviesRepository moviesRepository;

  GetMoviesWithPageUsecase(this.moviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(Params params) {    
    return moviesRepository.getMoviesWithPage(params.page);
  }

}

class Params extends Equatable {
  final int page;

  Params({@required this.page});

  @override
  List<Object> get props => [page];

}