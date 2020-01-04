import'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/features/movies/domain/usecases/get_movies_with_page_usecase.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/get_movies_bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/core/error/error_message_chooser.dart';
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesWithPageUsecase _getMoviesWithPageUseCase;
  int nextPage = 1;
  final List<Movie> infiniteMoviesList = List();

  MoviesBloc({
    @required GetMoviesWithPageUsecase getMoviesWithPageUsecase,
  }) : assert(getMoviesWithPageUsecase != null),
       _getMoviesWithPageUseCase = getMoviesWithPageUsecase;

  
  @override
  MoviesState get initialState => Empty();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if( event is GetMoviesWithPageEvent ) {
      if(infiniteMoviesList.length == 0){
        yield Loading();
      }else{
        yield LoadingMore(previousMovies: infiniteMoviesList);
      }
      final failureOrMovies = await _getMoviesWithPageUseCase(Params(page: this.nextPage));
      yield* failureOrMovies.fold(
        (failure) async*{
          String message = chooseErrorMessage(failure);
          yield Error(message: message);
        },
        (moviesList) async* {
          incrementPage();
          infiniteMoviesList.addAll(moviesList);
          yield Loaded(movies: infiniteMoviesList);
        }
      );
    }
  }

  void incrementPage() {
    nextPage++;
  }

}
