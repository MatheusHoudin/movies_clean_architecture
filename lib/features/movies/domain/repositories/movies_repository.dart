import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';

abstract class MoviesRepository{
  Future<Either<Failure, Movie>> getMoviesWithPage(int page);
}