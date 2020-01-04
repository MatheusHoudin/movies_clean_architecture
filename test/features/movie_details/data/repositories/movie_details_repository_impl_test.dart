import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/movie_details_model.dart';
import 'package:movies_clean_architecture/features/movie_details/data/repositories/movie_details_repository_impl.dart';
import 'package:movies_clean_architecture/features/movie_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:movies_clean_architecture/features/movie_details/data/datasources/movie_details_local_data_source.dart';
class NetworkInfoMock extends Mock implements NetworkInfo {}
class MovieDetailsRemoteDataSourceMock extends Mock implements MovieDetailsRemoteDataSource {}
class MovieDetailsLocalDataSourceMock extends Mock implements MovieDetailsLocalDataSource {}

void main() {
  MovieDetailsRepositoryImpl movieDetailsRepositoryImpl;
  NetworkInfoMock networkInfoMock;
  MovieDetailsLocalDataSourceMock localDataSourceMock;
  MovieDetailsRemoteDataSourceMock remoteDataSourceMock;
  int movieId = 1;
  MovieDetailsModel movieDetailsModel = MovieDetailsModel.fromJson(json.decode(fixture('movie_details.json')));
  setUp((){
    networkInfoMock = NetworkInfoMock();
    localDataSourceMock = MovieDetailsLocalDataSourceMock();
    remoteDataSourceMock = MovieDetailsRemoteDataSourceMock();
    movieDetailsRepositoryImpl = MovieDetailsRepositoryImpl(
      networkInfo: networkInfoMock,
      movieDetailsLocalDataSource: localDataSourceMock,
      movieDetailsRemoteDataSource: remoteDataSourceMock
    );
  });

  group('the device is online', () {
    setUp((){
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
    });

    test('should check that the devide is online',
      () async {
        movieDetailsRepositoryImpl.getMovieDetails(movieId);
        verify(networkInfoMock.isConnected);
      }
    );

    test('should cache the movie details model when call to remote data source is successful',
      () async {
        when(remoteDataSourceMock.getMovieDetailsModel(any)).thenAnswer((_) async => movieDetailsModel);
        await movieDetailsRepositoryImpl.getMovieDetails(movieId);
        verify(remoteDataSourceMock.getMovieDetailsModel(movieId));
        verify(localDataSourceMock.cacheMovieDetails(movieDetailsModel));
      }
    );
    
    test('should call the remote data source',
      () async {
        when(remoteDataSourceMock.getMovieDetailsModel(any)).thenAnswer((_) async => movieDetailsModel);

        final result = await movieDetailsRepositoryImpl.getMovieDetails(movieId);
        verify(remoteDataSourceMock.getMovieDetailsModel(movieId));
        expect(Right(movieDetailsModel), result);
      }
    );

    test('should return a ServerFailure when call to the remote repository is unsuccessful',
      () async {
        when(remoteDataSourceMock.getMovieDetailsModel(movieId))
            .thenThrow(ServerException());

        final result = await movieDetailsRepositoryImpl.getMovieDetails(movieId);

        verify(remoteDataSourceMock.getMovieDetailsModel(movieId));
        verifyZeroInteractions(localDataSourceMock);

        expect(Left(ServerFailure()), result);
      }
    );

  });

  group('the device is offline', () {
    setUp((){
      when(networkInfoMock.isConnected).thenAnswer((_) async => false);
    });

    test('should check that the devide is offline', () async {
      movieDetailsRepositoryImpl.getMovieDetails(movieId);
      verify(networkInfoMock.isConnected);
    }
    );

    test('should call the local data source', () async {
      when(localDataSourceMock.getCachedMovieDetails(any)).thenAnswer((_) async => movieDetailsModel);
      final result = await movieDetailsRepositoryImpl.getMovieDetails(movieId);

      verify(localDataSourceMock.getCachedMovieDetails(movieId));
      expect(Right(movieDetailsModel), result);
    }
    );

    test('should return a CacheFailure when call to local data source is unsuccessful',
      () async {
        when(localDataSourceMock.getCachedMovieDetails(movieId)).thenThrow(CacheException());

        final result = await movieDetailsRepositoryImpl.getMovieDetails(movieId);

        verify(localDataSourceMock.getCachedMovieDetails(movieId));
        expect(Left(CacheFailure()),result);
      }
    );
  });
}