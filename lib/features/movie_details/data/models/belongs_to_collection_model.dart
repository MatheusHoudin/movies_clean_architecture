import 'package:movies_clean_architecture/features/movie_details/domain/entities/belongs_to_collection.dart';
import 'package:meta/meta.dart';

class BelongsToCollectionModel extends BelongsToCollection{
  BelongsToCollectionModel({
    @required int id,
    @required String name,
    @required String posterPath,
    @required String backdropPath
  }) : super(id: id,name: name,posterPath: posterPath, backdropPath: backdropPath);

  factory BelongsToCollectionModel.fromJson(Map<String,dynamic> json) {
    return BelongsToCollectionModel(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path']
    );
  }
}