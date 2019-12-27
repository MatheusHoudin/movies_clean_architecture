import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/genre_entity.dart';
class GenreModel extends Genre {

  GenreModel({
    @required int id,
    @required String name
  }) : super(id: id,name:name);

  factory GenreModel.fromJson(Map<String,dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name']
    );
  }

  Map<String,dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name
    };
  }
}