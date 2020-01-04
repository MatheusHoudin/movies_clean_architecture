import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/change_movies_view_bloc/bloc.dart';

void main() {
  ChangeMoviesViewBloc moviesViewBloc;

  setUp((){
    print('setup');
    moviesViewBloc = ChangeMoviesViewBloc();
  });

  test('initial state should be MoviesWithDescriptionState',
    () async {
      expect(moviesViewBloc.initialState, isA<MoviesWithDescriptionState>());
    }
  );

  test('should change the state between MoviesWithDescriptionState and MoviesWithImageState',
    () async {
      final expect = [
        MoviesWithDescriptionState(),
        MoviesWithImageState(),
        MoviesWithDescriptionState()
      ];

      expectLater(moviesViewBloc.cast(), emitsInOrder(expect));

      moviesViewBloc.add(ChangeMoviesViewEvent());
      moviesViewBloc.add(ChangeMoviesViewEvent());
    }
  );
}