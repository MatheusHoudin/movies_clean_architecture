import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/core/error/exceptions.dart';
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
  Future<Either<Failure, List<Movie>>> getMoviesWithPage(int page) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if(isConnected){
        final remoteMovies = await moviesRemoteDataSource.getMoviesWithPage(page);
        await moviesLocalDataSource.cacheMovies(remoteMovies);
        return Right(remoteMovies);
      }else{
        final localMovies = await moviesLocalDataSource.getLastMovies();
        return Right(localMovies);
      }
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

}