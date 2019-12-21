import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_local_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MoviesBoxMock extends Mock implements Box {}

void main() {
  MoviesLocalDataSource dataSource;
  MoviesBoxMock boxMock;

  setUp(() {
    boxMock = MoviesBoxMock();
    dataSource = MoviesLocalDataSourceImpl(moviesBox: boxMock);
  });

  group('getLastMovies', () {
    final movie1 = MovieModel.fromJson(json.decode(fixture('movie.json')));
    final movie2 = MovieModel.fromJson(json.decode(fixture('movie2.json')));
    final movies = [movie1,movie2];

    test(
      'should return the last cached movies from the local database',
      () async {
        when(boxMock.get(any)).thenReturn('{"movies": ${movies.toString()}}');

        final result = await dataSource.getLastMovies();
        verify(boxMock.get(CACHED_MOVIES));
        expect(result,movies);
      }
    );

    test(
      'should return a cache exception when there is no cached data',
      () async {
        when(boxMock.get(any)).thenReturn(null);

        final call = dataSource.getLastMovies;

        expect(() => call(), throwsA(isInstanceOf<CacheException>()));
      }
    );
  });

  group('cacheMovies', () {
    final movie1 = MovieModel.fromJson(json.decode(fixture('movie.json')));
    final movie2 = MovieModel.fromJson(json.decode(fixture('movie2.json')));
    final movies = [movie1,movie2];

    test(
      'should call Box to cache the movies',
      () async {
        dataSource.cacheMovies(movies);

        verify(boxMock.put(CACHED_MOVIES,'{"movies": ${movies.toString()}}'));
      }
    );
  });
}