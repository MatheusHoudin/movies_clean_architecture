import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final tMovieModel = MovieModel(
    id: 1,
    adult: true,
    overview: "overview",
    posterPath: 'poster.png',
    releaseDate: '2019-10-10',
    title: 'title',
    voteAverage: 9.0,
    genreIds: [1,2,3]);

  test(
    'should be a subclass of Movie entity',
    () async {
      expect(tMovieModel, isA<Movie>());
    }
  );

  test(
    'should return a valid model containing the json data',
    () async {
      final Map<String,dynamic> jsonMap = json.decode(fixture('movie.json'));
      final result = MovieModel.fromJson(jsonMap);

      expect(result,tMovieModel);
    }
  );

  test(
    'should return a valid JSON containing the object data',
    () async {
      final result = tMovieModel.toJson();

      final expectedMap = {
        "id": 1,
        "adult": true,
        "overview": "overview",
        "poster_path": "poster.png",
        "release_date": "2019-10-10",
        "title": "title",
        "vote_average": 9.0,
        "genre_ids": [1,2,3]
      };

      expect(result,equals(expectedMap));
    }
  );
}