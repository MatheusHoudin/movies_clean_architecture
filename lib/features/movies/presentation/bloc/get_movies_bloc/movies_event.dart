import 'package:equatable/equatable.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/get_movies_bloc/bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class GetMoviesWithPageEvent extends MoviesEvent {
  GetMoviesWithPageEvent();

  @override
  List<Object> get props => [];

}