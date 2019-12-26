import 'package:equatable/equatable.dart';
class BelongsToCollection implements Equatable{
  final int id;
  final String name,posterPath,backdropPath;

  BelongsToCollection({this.id,this.name,this.posterPath,this.backdropPath});

  @override
  List<Object> get props => [
    id,
    name,
    posterPath,
    backdropPath
  ];

}