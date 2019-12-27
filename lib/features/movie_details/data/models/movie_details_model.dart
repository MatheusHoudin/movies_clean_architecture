import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/genre_model.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/belongs_to_collection_model.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/production_company_model.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/movie_details_model.dart';
class MovieDetailsModel extends MovieDetailsEntity {

  MovieDetailsModel({
    @required int id,
    @required bool adult,
    @required String backdropPath,
    @required String homepage,
    @required String title,
    @required String overview,
    @required String posterPath,
    @required String releaseDate,
    @required BelongsToCollectionModel belongsToCollection,
    @required List<GenreModel> genres,
    @required List<ProductionCompanyModel> productionCompanies,
    @required double voteAverage
  }) : super(voteAverage:voteAverage,productionCompanies:productionCompanies,genres:genres,
  belongsToCollection:belongsToCollection,id:id,adult:adult,backdropPath:backdropPath,
  homepage:homepage,title:title,overview:overview,posterPath:posterPath,releaseDate:releaseDate);

  factory MovieDetailsModel.fromJson(Map<String,dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      homepage: json['homepage'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      belongsToCollection: BelongsToCollectionModel.fromJson(json['belongs_to_collection']),
      genres: (json['genres'] as List).map((i) => GenreModel.fromJson(i)).toList(),
      productionCompanies: (json['production_companies'] as List).map((i) => ProductionCompanyModel.fromJson(i)).toList()
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'id': this.id,
      'adult': this.adult,
      'backdrop_path': this.backdropPath,
      'homepage': this.homepage,
      'title': this.title,
      'overview': this.overview,
      'poster_path': this.posterPath,
      'release_date': this.releaseDate,
      'vote_average': this.voteAverage,
      'belongs_to_collection': (this.belongsToCollection as BelongsToCollectionModel).toJson(),
      'genres': this.genres.map((i) => (i as GenreModel).toJson()).toList(),
      'production_companies': this.productionCompanies.map((i) => (i as ProductionCompanyModel).toJson()).toList(),
    };
  }
}