import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MoviesRemoteDataSourceImpl moviesRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    moviesRemoteDataSourceImpl = MoviesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(){
    when(mockHttpClient.get(any))
    .thenAnswer((_) async => http.Response([fixture('movie.json'),fixture('movie2.json')].toString(),200));
  }

  void setUpMockHttpClientFailure404(){
    when(mockHttpClient.get(any))
    .thenAnswer((_) async => http.Response('Something went wrong',404));
  }

  group('getMoviesWithPage', (){
    int page = 1;
    final tMovies = [
      MovieModel.fromJson(json.decode(fixture('movie.json'))),
      MovieModel.fromJson(json.decode(fixture('movie2.json')))
    ];

    test(
      'should return a List of MovieModel when the response code is 200 (success)',
      () async {
        setUpMockHttpClientSuccess200();
        final result = await moviesRemoteDataSourceImpl.getMoviesWithPage(page);
        expect(result, equals(tMovies));
      }
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        setUpMockHttpClientFailure404();
        final call = moviesRemoteDataSourceImpl.getMoviesWithPage;

        expect(() => call(page),throwsA(TypeMatcher<ServerException>()));
      }
    );

  });
}