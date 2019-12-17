import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/features/movies/domain/usecases/get_movies_with_page_usecase.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesWithPageUsecase _getMoviesWithPageUseCase;
  int nextPage = 1;
  final List<Movie> infiniteMoviesList = List();

  MoviesBloc({
    @required getMoviesWithPageUsecase,
  }) : assert(getMoviesWithPageUsecase != null),
       _getMoviesWithPageUseCase = getMoviesWithPageUsecase;

  
  @override
  MoviesState get initialState => Empty();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if( event is GetMoviesWithPageEvent ) {
      yield Loading();
      final failureOrMovies = await _getMoviesWithPageUseCase(Params(page: this.nextPage));

      yield failureOrMovies.fold(
        (failure) {
          String message = chooseErrorMessage(failure);
          return Error(message: message);
        },
        (moviesList) {
          incrementPage();
          infiniteMoviesList.addAll(moviesList);
          return Loaded(movies: infiniteMoviesList);
        }
      );
    }
  }

  void incrementPage() {
    nextPage++;
  }

  String chooseErrorMessage(Failure failure){
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE;
      case CacheFailure:
        return CACHE_FAILURE;
      default:
        return 'An unexpected error has ocurrer';  
    }
  }
}
