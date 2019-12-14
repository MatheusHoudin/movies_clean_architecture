import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_local_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesLocalDataSource moviesLocalDataSource;
  final MoviesRemoteDataSource moviesRemoteDataSource;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl({
    @required this.moviesLocalDataSource,
    @required this.moviesRemoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, Movie>> getMoviesWithPage(int page) {
    networkInfo.isConnected;
    return null;
  }

}