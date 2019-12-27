import 'package:movies_clean_architecture/features/movie_details/domain/entities/belongs_to_collection_entity.dart';
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

  Map<String,dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "poster_path": this.posterPath,
      "backdrop_path": this.backdropPath
    };
  }

  String toString() {
    return '{id: $id,name: $name,poster_path: $posterPath,backdrop_path: $backdropPath}';
  }
}