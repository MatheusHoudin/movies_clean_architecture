import 'package:equatable/equatable.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
}

class Loading extends MoviesState {
  @override
  List<Object> get props => [];
}

class Empty extends MoviesState {
  @override
  List<Object> get props => [];
}

class Loaded extends MoviesState {
  final List<Movie> movies;

  Loaded({this.movies});

  @override
  List<Object> get props => [movies];
}

class Error extends MoviesState {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message]; 
}
