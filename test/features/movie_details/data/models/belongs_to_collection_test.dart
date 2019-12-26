import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/belongs_to_collection_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/belongs_to_collection.dart';
void main() {
  final tBelongsToCollection = BelongsToCollectionModel(
    id: 1,
    name: "Collection",
    backdropPath: "/ndsojHB9Ob9BE3Bjnd.jpg",
    posterPath: "/jbBihBbh9obno9bn.jpg"
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
        Map<String,dynamic> jsonModel = json.decode(fixture('belongs_to_collection.json'));
        print(jsonModel);
        final result = BelongsToCollectionModel.fromJson(jsonModel);
        print(result);

        expect(result, tBelongsToCollection);
    }
  );
}