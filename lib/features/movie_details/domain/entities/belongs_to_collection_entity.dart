import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
class BelongsToCollection extends Equatable{
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  BelongsToCollection({
    @required this.id,
    @required this.name,
    @required this.posterPath,
    @required this.backdropPath
  });

  @override
  List<Object> get props => [
    id,
    name,
    posterPath,
    backdropPath
  ];

}