import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/change_movies_view_bloc/bloc.dart';

class ChangeMoviesViewBloc extends Bloc<ChangeMoviesViewEvent, ChangeMoviesViewState> {
  @override
  ChangeMoviesViewState get initialState => MoviesWithDescriptionState();

  @override
  Stream<ChangeMoviesViewState> mapEventToState(
    MoviesViewEvent event,
  ) async* {
    if(event is ChangeMoviesViewEvent) {
      if(state is MoviesWithDescriptionState) {
        yield MoviesWithImageState();
      }else{
        yield MoviesWithDescriptionState();
      }
    }
  }
}
