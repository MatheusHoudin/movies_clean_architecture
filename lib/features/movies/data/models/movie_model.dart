import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType()
class MovieModel extends Movie {
  MovieModel({
    @required int id,
    @required double voteAverage,
    @required bool adult,
    @required String title,
    @required String overview,
    @required String releaseDate,
    @required String posterPath,
    @required List<int> genreIds
  }) : super(id: id,voteAverage: voteAverage,adult: adult,title: title,
  overview: overview,releaseDate: releaseDate,posterPath: posterPath,
  genreIds: genreIds);

  factory MovieModel.fromJson(Map<String,dynamic> json){
    print('JSON');
    print(json);
    return MovieModel(
      id: json['id'],
      voteAverage: json['vote_average'].toDouble(),
      adult: json['adult'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      genreIds: List<int>.from(json['genre_ids'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id": this.id,
      "vote_average": this.voteAverage,
      "adult": this.adult,
      "title": this.title,
      "overview": this.overview,
      "release_date": this.releaseDate,
      "poster_path": this.posterPath,
      "genre_ids": this.genreIds
    };
  }
}
