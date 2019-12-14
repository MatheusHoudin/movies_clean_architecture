import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Movie extends Equatable{
  final int id;
  final double voteAverage;
  final bool adult;
  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final List<int> genreIds;

  Movie({
    @required this.id,
    @required this.voteAverage,
    @required this.adult,
    @required this.title,
    @required this.overview,
    @required this.releaseDate,
    @required this.posterPath,
    @required this.genreIds
  });

  @override
  List<Object> get props => [
    id,
    voteAverage,
    adult,
    title,
    overview,
    releaseDate,
    posterPath,
    genreIds
  ];
}