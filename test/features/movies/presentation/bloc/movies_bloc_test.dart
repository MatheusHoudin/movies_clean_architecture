import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/util/input_converter.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/features/movies/domain/usecases/get_movies_with_page_usecase.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/bloc.dart';

class MockGetMoviesWithPageUsecase extends Mock implements GetMoviesWithPageUsecase {}

void main() {
  MoviesBloc moviesBloc;
  MockGetMoviesWithPageUsecase getMoviesWithPageUsecase;

  setUp(() {
    getMoviesWithPageUsecase = MockGetMoviesWithPageUsecase();
    moviesBloc = MoviesBloc(getMoviesWithPageUsecase: getMoviesWithPageUsecase);
  });

  test(
    'initial state should be Loading',
    () async {
      expect(moviesBloc.initialState,Empty());
    }
  );

  group(
    'GetMoviesWithPageUsecase', () {
      final moviesFirstCall = [
        Movie(id: 1,adult: true,genreIds: [1,2],overview: 'overview',posterPath: 'posterPath',releaseDate: 'date',title: 'title',voteAverage: 10),
        Movie(id: 2,adult: false,genreIds: [1,4],overview: 'overview1',posterPath: 'posterPath2',releaseDate: 'date3',title: 'title3',voteAverage: 9)
      ];

      final moviesSecondCall = [
        Movie(id: 1,adult: true,genreIds: [1,2],overview: 'overview22',posterPath: 'posterPath',releaseDate: 'date',title: 'title',voteAverage: 10),
        Movie(id: 2,adult: false,genreIds: [1,4],overview: 'overview22',posterPath: 'posterPath2',releaseDate: 'date3',title: 'title3',voteAverage: 9)
      ];

      final finalMoviesList = [
        Movie(id: 1,adult: true,genreIds: [1,2],overview: 'overview',posterPath: 'posterPath',releaseDate: 'date',title: 'title',voteAverage: 10),
        Movie(id: 2,adult: false,genreIds: [1,4],overview: 'overview1',posterPath: 'posterPath2',releaseDate: 'date3',title: 'title3',voteAverage: 9),
        Movie(id: 1,adult: true,genreIds: [1,2],overview: 'overview22',posterPath: 'posterPath',releaseDate: 'date',title: 'title',voteAverage: 10),
        Movie(id: 2,adult: false,genreIds: [1,4],overview: 'overview22',posterPath: 'posterPath2',releaseDate: 'date3',title: 'title3',voteAverage: 9)
      ];
      
      test(
        'GetMoviesWithPage should be called with the page on the MoviesBloc',
        () async {
          final expected = [
            Empty(),
            Loading(),
          ];
          expectLater(moviesBloc.cast(), emitsInOrder(expected));
          moviesBloc.add(GetMoviesWithPageEvent());
          
          await untilCalled(getMoviesWithPageUsecase(any));
          verify(getMoviesWithPageUsecase(Params(page: moviesBloc.nextPage)));
        }
      );

      test(
        'GetMoviesWithPage should return the movies list referred to the first page',
        () async {
          when(getMoviesWithPageUsecase(any))
          .thenAnswer((_) async => Right(moviesFirstCall));
          final expected = [
            Empty(),
            Loading(),
            Loaded(movies: moviesFirstCall)
          ];
          expectLater(moviesBloc.cast(),emitsInOrder(expected));
          moviesBloc.add(GetMoviesWithPageEvent());
        }
      );

      test(
        'GetMoviesWithPage should emit [Loading,Error] when getting remote data fails',
        () async {
          when(getMoviesWithPageUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

          final expected = [
            Empty(),
            Loading(),
            Error(message: SERVER_FAILURE)
          ];
          expectLater(moviesBloc.cast(), emitsInOrder(expected));
          moviesBloc.add(GetMoviesWithPageEvent());
        }
      );

      test(
        'GetMoviesWithPage should emit [Loading,Error] when getting cached data fails',
        () async {
          when(getMoviesWithPageUsecase(any))
          .thenAnswer((_) async => Left(CacheFailure()));

          final expected = [
            Empty(),
            Loading(),
            Error(message: CACHE_FAILURE)
          ];
          expectLater(moviesBloc.cast(), emitsInOrder(expected));
          moviesBloc.add(GetMoviesWithPageEvent());
        }
      );

      test(
        'should concatenate the previous movies list with the new on when getting data is successful',
        () async {
          when(getMoviesWithPageUsecase(any))
          .thenAnswer((_) async => Right(moviesFirstCall));

          final expected = [
            Empty(),
            Loading(),
            Loaded(movies: moviesFirstCall),
            LoadingMore(previousMovies: moviesFirstCall),
            Loaded(movies: finalMoviesList),
          ];

          expectLater(moviesBloc.cast(), emitsInOrder(expected));
        
          moviesBloc.add(GetMoviesWithPageEvent());
          await untilCalled(getMoviesWithPageUsecase(any));
          verify(getMoviesWithPageUsecase(Params(page: moviesBloc.nextPage)));
          clearInteractions(getMoviesWithPageUsecase);

          when(getMoviesWithPageUsecase(any))
          .thenAnswer((_) async =>  Right(moviesSecondCall));

          moviesBloc.add(GetMoviesWithPageEvent());
          await untilCalled(getMoviesWithPageUsecase(any));
          verify(getMoviesWithPageUsecase(Params(page: moviesBloc.nextPage)));
        }
      );

      test(
        'should increment the page number after a successful call',
        () async {
          when(getMoviesWithPageUsecase(any))
          .thenAnswer((_) async => Right(moviesFirstCall));
          
          moviesBloc.add(GetMoviesWithPageEvent());
          await untilCalled(moviesBloc.incrementPage());
          expect(moviesBloc.nextPage,2);
        }
      );

      test(
        'should not increment the page number after an unsuccessful call',
        () async {
          when(getMoviesWithPageUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));
          
          moviesBloc.add(GetMoviesWithPageEvent());
          expect(moviesBloc.nextPage,1);
        }
      );

    }
  );
}