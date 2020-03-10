import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movies_clean_architecture/features/movie_details/presentation/bloc/bloc.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/core/error/error_message_chooser.dart';
class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  GetMovieDetailsUsecase _getMovieDetailsUsecase;

  MovieDetailsBloc({
    @required GetMovieDetailsUsecase getMovieDetailsUsecase
  }) : assert(getMovieDetailsUsecase!=null), this._getMovieDetailsUsecase = getMovieDetailsUsecase;

  @override
  MovieDetailsState get initialState => Loading();

  @override
  Stream<MovieDetailsState> mapEventToState(
    MovieDetailsEvent event,
  ) async* {
    if( event is GetMovieDetailsEvent ){
      final movieDetailsOrFailure = await _getMovieDetailsUsecase(Params(movieId: event.movieId));

      yield* movieDetailsOrFailure.fold(
        (failure) async* {
          String errorMessage = chooseErrorMessage(failure);
          yield Error(message: errorMessage);
        },
        (movieDetails) async* {
          print(movieDetails.productionCompanies);
          yield Loaded(movieDetailsEntity: movieDetails);
        }
      );
    }
  }
}
