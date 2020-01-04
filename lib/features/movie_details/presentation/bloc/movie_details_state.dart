import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_details_entity.dart';
import 'package:meta/meta.dart';
abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
}

class Loading extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class Loaded extends MovieDetailsState {
  final MovieDetailsEntity movieDetailsEntity;

  Loaded({@required this.movieDetailsEntity});

  @override
  List<Object> get props => [movieDetailsEntity];
}

class Error extends MovieDetailsState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
