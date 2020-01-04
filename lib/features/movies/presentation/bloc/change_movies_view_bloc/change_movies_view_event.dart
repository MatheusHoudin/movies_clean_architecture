import 'package:equatable/equatable.dart';

abstract class MoviesViewEvent extends Equatable {
  const MoviesViewEvent();
}

class ChangeMoviesViewEvent extends MoviesViewEvent {
  @override
  List<Object> get props => [];

}
