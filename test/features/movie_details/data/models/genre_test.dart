import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/genre_model.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/genre_entity.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';
void main() {
  final tGenre = GenreModel(
    name: 'action',
    id: 1
  );

  test(
    'GenreModel is an instance of Genre',
    () async {
      expect(tGenre, isA<Genre>());
    }
  );

  test(
    'should return a valid GenreModel when converting json',
    () async {
      final jsonMap = json.decode(fixture('genre.json'));
      final result = GenreModel.fromJson(jsonMap);

      expect(result, tGenre);
    }
  );

  test(
    'should convert the GenreModel to proper json',
    () async {
      final expectedJson = {
        "id": 1,
        "name": "action"
      };
      final result = tGenre.toJson();
      expect(expectedJson, result);
    }
  );
}