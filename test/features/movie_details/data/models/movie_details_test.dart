import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/production_company_model.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/genre_model.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/belongs_to_collection_model.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/movie_details_model.dart';
void main() {

  final tMovieDetailsModel = MovieDetailsModel(
    id: 1,
    adult: true,
    backdropPath: 'backdrop',
    homepage: 'homepage',
    title: 'title',
    overview: 'overview',
    posterPath: 'poster',
    releaseDate: 'date',
    voteAverage: 10.0,
    belongsToCollection: BelongsToCollectionModel(
        id: 1,
        name: 'Collection',
        posterPath: '/ndsojHB9Ob9BE3Bjnd.jpg',
        backdropPath: '/jbBihBbh9obno9bn.jpg'
    ),
    genres: [
      GenreModel(
        id: 1,
        name: 'action'
      ),
      GenreModel(
        id: 2,
        name: 'romance'
      )
    ],
    productionCompanies: [
      ProductionCompanyModel(
        id: 1,
        name: 'company',
        logoPath: 'logo',
        originCountry: 'country'
      ),
      ProductionCompanyModel(
          id: 2,
          name: 'company2',
          logoPath: 'logo2',
          originCountry: 'country2'
      )
    ]
  );

  test(
    'should be an instance of MovieDetails entity',
    () async {
      expect(tMovieDetailsModel, isA<MovieDetailsEntity>());
    }
  );

  test(
    'should convert the json and return a proper MovieDetailsModel',
    () async {
      final jsonMap = json.decode(fixture('movie_details.json'));
      final result = MovieDetailsModel.fromJson(jsonMap);

      expect(tMovieDetailsModel, result);
    }
  );

  test(
    'should return proper json according to MovieDetailsModel object',
    () async {
      final expectedJson = {
        "id": 1,
        "adult": true,
        "backdrop_path": "backdrop",
        "homepage": "homepage",
        "title": "title",
        "overview": "overview",
        "poster_path": "poster",
        "release_date": "date",
        "vote_average": 10.0,
        "belongs_to_collection": {
          "id": 1,
          "name": "Collection",
          "poster_path": "/ndsojHB9Ob9BE3Bjnd.jpg",
          "backdrop_path": "/jbBihBbh9obno9bn.jpg"
        },
        "genres": [
          {
            "id": 1,
            "name": "action"
          },
          {
            "id": 2,
            "name": "romance"
          }
        ],
        "production_companies": [
          {
            "id": 1,
            "name": "company",
            "logo_path": "logo",
            "origin_country": "country"
          },
          {
            "id": 2,
            "name": "company2",
            "logo_path": "logo2",
            "origin_country": "country2"
          }
        ]
      };
      final result = tMovieDetailsModel.toJson();

      expect(expectedJson,result);
    }
  );
}