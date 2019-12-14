import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_local_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';
import 'package:movies_clean_architecture/features/movies/data/repositories/movies_repository_impl.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockMoviesRemoteDataSource extends Mock implements MoviesRemoteDataSource{}
class MockMoviesLocalDataSource extends Mock implements MoviesLocalDataSource{}
class MockNetworkInfo extends Mock implements NetworkInfo{}

main() {
  MoviesRepositoryImpl moviesRepositoryImpl;
  MockMoviesRemoteDataSource moviesRemoteDataSource;
  MockMoviesLocalDataSource moviesLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  final tMovies = [
      MovieModel.fromJson(json.decode(fixture('movie.json'))),
      MovieModel.fromJson(json.decode(fixture('movie2.json')))
    ];
  int page = 1;

  setUp((){
    moviesLocalDataSource = MockMoviesLocalDataSource();
    moviesRemoteDataSource = MockMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    moviesRepositoryImpl = MoviesRepositoryImpl(
      moviesLocalDataSource: moviesLocalDataSource,
      moviesRemoteDataSource: moviesRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('device is online', () {

    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test(
      'should check if the device is online',
      () async {
        moviesRepositoryImpl.getMoviesWithPage(page);

        verify(mockNetworkInfo.isConnected);
      }
    );

    test(
      'should return remote data when call to remote data source is successful',
      () async {
         when(moviesRemoteDataSource.getMoviesWithPage(page))
         .thenAnswer((_) async => tMovies);

         final result = await moviesRepositoryImpl.getMoviesWithPage(page);

         verify(moviesRemoteDataSource.getMoviesWithPage(page));
         expect(result, equals(Right(tMovies)));
      }
    );

    test(
      'should cache data locally when call to remote data source is successful',
      () async {
        when(moviesRemoteDataSource.getMoviesWithPage(page))
        .thenAnswer((_) async => tMovies);

        await moviesRepositoryImpl.getMoviesWithPage(page);

        verify(moviesRemoteDataSource.getMoviesWithPage(page));
        verify(moviesLocalDataSource.cacheMovies(tMovies));
      }
    );

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        when(moviesRemoteDataSource.getMoviesWithPage(page))
        .thenThrow(ServerException());

        final result = await moviesRepositoryImpl.getMoviesWithPage(page);

        verify(moviesRemoteDataSource.getMoviesWithPage(page));
        verifyZeroInteractions(moviesLocalDataSource);
        expect(result, Left(ServerFailure()));
      }
    );
   
  });
  
  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test(
      'should check if the device is offnline',
      () async {
        moviesRepositoryImpl.getMoviesWithPage(1);

        verify(mockNetworkInfo.isConnected);
      }
    );

    test(
      'should return local data when there is no internet connection',
      () async {
        when(moviesLocalDataSource.getLastMovies())
        .thenAnswer((_) async => tMovies);
        
        final result = await moviesRepositoryImpl.getMoviesWithPage(page);

        verifyZeroInteractions(moviesRemoteDataSource);
        verify(moviesLocalDataSource.getLastMovies());
        expect(result, Right(tMovies));
      }
    );

    test(
      'should return cache failure when there is an error on the local data source',
      () async {
        when(moviesLocalDataSource.getLastMovies())
        .thenThrow(CacheException());

        final result = await moviesRepositoryImpl.getMoviesWithPage(page);

        verify(moviesLocalDataSource.getLastMovies());
        expect(result,Left(CacheFailure()));
      }
    );
  });
}