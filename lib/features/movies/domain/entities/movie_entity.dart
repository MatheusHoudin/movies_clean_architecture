import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';

@HiveType()
class Movie extends Equatable{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double voteAverage;
  @HiveField(2)
  final bool adult;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String overview;
  @HiveField(5)
  final String releaseDate;
  @HiveField(6)
  final String posterPath;
  @HiveField(7)
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