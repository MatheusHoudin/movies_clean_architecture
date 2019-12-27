import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'belongs_to_collection_entity.dart';
import 'genre_entity.dart';
import 'production_company_entity.dart';
class MovieDetailsEntity extends Equatable {
  final int id;
  final bool adult;
  final String backdropPath,homepage,title,overview,
      posterPath,releaseDate;
  final BelongsToCollection belongsToCollection;
  final List<Genre> genres;
  final List<ProductionCompany> productionCompanies;
  final double voteAverage;

  MovieDetailsEntity({
    @required this.id,
    @required this.adult,
    @required this.backdropPath,
    @required this.homepage,
    @required this.title,
    @required this.overview,
    @required this.posterPath,
    @required this.releaseDate,
    @required this.belongsToCollection,
    @required this.genres,
    @required this.productionCompanies,
    @required this.voteAverage
  });

  @override
  List<Object> get props => [
    this.id,
    this.adult,
    this.backdropPath,
    this.homepage,
    this.title,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.belongsToCollection,
    this.genres,
    this.productionCompanies,
    this.voteAverage
  ];


}