import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;

  GetMovieDetailsEvent({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}
