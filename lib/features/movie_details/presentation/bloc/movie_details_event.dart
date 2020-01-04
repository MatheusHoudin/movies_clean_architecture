import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

class LoadMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;

  LoadMovieDetailsEvent({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}
