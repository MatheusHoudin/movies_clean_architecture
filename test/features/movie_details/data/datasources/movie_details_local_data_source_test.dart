import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import '../../../../fixtures/fixture_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/movie_details_model.dart';
import 'package:movies_clean_architecture/features/movie_details/data/datasources/movie_details_local_data_source.dart';
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main(){
  MovieDetailsLocalDataSource movieDetailsLocalDataSource;
  MockSharedPreferences mockSharedPreferences;
  final tMovieDetailsModel = MovieDetailsModel.fromJson(json.decode(fixture('movie_details.json')));
  final tMovieId = 1;
  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    movieDetailsLocalDataSource = MovieDetailsLocalDataSourceImpl(preferences: mockSharedPreferences);
  });

  void setUpPreferencesGetCachedMovieDetails() {
    when(mockSharedPreferences.get(any))
        .thenReturn(fixture('movie_details.json'));
  }

  group('CacheMovieDetails', () {
    test('should cache the movie details with its id as key and a json as the value',
        () async {
          await movieDetailsLocalDataSource.cacheMovieDetails(tMovieDetailsModel);
          verify(mockSharedPreferences.setString(tMovieDetailsModel.id.toString(), tMovieDetailsModel.toJson().toString()));
        }
    );
  });

  group('GetCachedMovieDetails', () {


    test('should call the preferences with the movie id',
      () async {
        setUpPreferencesGetCachedMovieDetails();
        await movieDetailsLocalDataSource.getCachedMovieDetails(tMovieId);

        verify(mockSharedPreferences.get(tMovieId.toString()));
      }
    );

    test('should return cached movie details model',
      () async {
        setUpPreferencesGetCachedMovieDetails();
        final result = await movieDetailsLocalDataSource.getCachedMovieDetails(tMovieId);

        expect(tMovieDetailsModel, result);
      }
    );
  });

}
