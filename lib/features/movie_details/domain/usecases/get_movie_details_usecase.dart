import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/repositories/movie_details_repository.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
class GetMovieDetailsUsecase extends UseCase<MovieDetailsEntity,Params> {
  final MovieDetailsRepository movieDetailsRepository;

  GetMovieDetailsUsecase({@required this.movieDetailsRepository});

  @override
  Future<Either<Failure, MovieDetailsEntity>> call(Params params) {
    return movieDetailsRepository.getMovieDetails(params.movieId);
  }

}

class Params extends Equatable {
  final int movieId;

  Params({@required this.movieId});

  @override
  List<Object> get props => [movieId];

}