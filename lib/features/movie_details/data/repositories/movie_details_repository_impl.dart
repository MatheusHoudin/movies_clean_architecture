import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/repositories/movie_details_repository.dart';
import 'package:movies_clean_architecture/features/movie_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:movies_clean_architecture/features/movie_details/data/datasources/movie_details_local_data_source.dart';
class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  MovieDetailsLocalDataSource movieDetailsLocalDataSource;
  MovieDetailsRemoteDataSource movieDetailsRemoteDataSource;
  NetworkInfo networkInfo;

  MovieDetailsRepositoryImpl({
    @required this.movieDetailsLocalDataSource,
    @required this.movieDetailsRemoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(int movieId) async{
    final isConnected = await networkInfo.isConnected;
    try {
      if(isConnected) {
        final result = await movieDetailsRemoteDataSource.getMovieDetailsModel(movieId);
        movieDetailsLocalDataSource.cacheMovieDetails(result);
        return Right(result);
      }else{
        final result = await movieDetailsLocalDataSource.getCachedMovieDetails(movieId);
        return Right(result);
      }
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

}