import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
abstract class MovieDetailsRepository {
  Future<Either<Failure,MovieDetailsEntity>> getMovieDetails(int movieId);
}