import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/belongs_to_collection_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/belongs_to_collection_entity.dart';
void main() {
  final tBelongsToCollection = BelongsToCollectionModel(
    id: 1,
    name: "Collection",
    backdropPath: "/jbBihBbh9obno9bn.jpg",
    posterPath: "/ndsojHB9Ob9BE3Bjnd.jpg"
  );

  test(
    'should be an instance of BelongsToCollection',
    () async {
      expect(tBelongsToCollection, isA<BelongsToCollection>());
    }
  );

  test(
    'should return an instance of BelongsToCollectionModel when converting proper json',
    () async {
        final jsonModel = json.decode(fixture('belongs_to_collection.json'));
        print(jsonModel);
        final result = BelongsToCollectionModel.fromJson(jsonModel);
        print(result);
        expect(tBelongsToCollection,result);
    }
  );

  test(
    'should return a proper json',
    () async {
      final collectionJson = {
        "id": 1,
        "name": "Collection",
        "backdrop_path": "/jbBihBbh9obno9bn.jpg",
        "poster_path": "/ndsojHB9Ob9BE3Bjnd.jpg"
      };
      final result = tBelongsToCollection.toJson();

      expect(result, collectionJson);
    }
  );

}