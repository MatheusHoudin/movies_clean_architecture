import 'package:equatable/equatable.dart';

abstract class ChangeMoviesViewState extends Equatable {
  const ChangeMoviesViewState();
}

class MoviesWithDescriptionState extends ChangeMoviesViewState {
  @override
  List<Object> get props => [];
}

class MoviesWithImageState extends ChangeMoviesViewState {
  @override
  List<Object> get props => [];
}
