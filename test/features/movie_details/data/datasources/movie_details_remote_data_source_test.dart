import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';
import 'package:matcher/matcher.dart';
import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/movie_details_model.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'package:movies_clean_architecture/features/movie_details/data/datasources/movie_details_remote_data_source.dart';
class MockHttpClient extends Mock implements http.Client {}

void main() {
  MovieDetailsRemoteDataSource dataSource;
  MockHttpClient httpClient;
  final movieId = 1;
  final tMovieDetailsModel = MovieDetailsModel.fromJson(json.decode(fixture('movie_details.json')));
  setUp((){
    httpClient = MockHttpClient();
    dataSource = MovieDetailsRemoteDataSourceImpl(client: httpClient);
  });

  void setUpHttpClientMockSuccessfulRequest() {
    when(httpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('movie_details.json'),200));
  }

  void setUpHttpClientMockUnsuccessfulRequest() {
    when(httpClient.get(any))
        .thenAnswer((_) async => http.Response("The resource you requested could not be found.",404));
  }

  group(
    'successful call to remote data source', () {
      test(
          'should be called with the right url',
              () async {
            setUpHttpClientMockSuccessfulRequest();
            await dataSource.getMovieDetailsModel(movieId);
            verify(httpClient.get('${baseUrl}movie/$movieId?api_key=$apiKey'));
          }
      );

      test(
          'should return the movie details response when call to the service is successful(200)',
              () async {
            setUpHttpClientMockSuccessfulRequest();
            final result = await dataSource.getMovieDetailsModel(movieId);

            expect(tMovieDetailsModel, result);
          }
      );
  }
  );

  group(
    'unsuccessful call to remote data source', () {
    test(
      'should return a server exception when the response has the code 404',
      () async {
        setUpHttpClientMockUnsuccessfulRequest();
        final call = dataSource.getMovieDetailsModel;
        
        expect(() async => call(movieId), throwsA(TypeMatcher<ServerException>()));
      }
    );
  }
  );


}