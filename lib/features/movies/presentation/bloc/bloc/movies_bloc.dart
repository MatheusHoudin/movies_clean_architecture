import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/util/input_converter.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/features/movies/domain/usecases/get_movies_with_page_usecase.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesWithPageUsecase _getMoviesWithPageUseCase;
  final InputConverter _inputConverter;
  int nextPage = 1;
  final List<Movie> infiniteMoviesList = List();

  MoviesBloc({
    @required getMoviesWithPageUsecase,
    @required inputConverter
  }) : assert(getMoviesWithPageUsecase != null),
       assert(inputConverter != null),
       _getMoviesWithPageUseCase = getMoviesWithPageUsecase,
       _inputConverter = inputConverter;

  
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
          nextPage++;
          infiniteMoviesList.addAll(moviesList);
          return Loaded(movies: infiniteMoviesList);
        }
      );
    }
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
