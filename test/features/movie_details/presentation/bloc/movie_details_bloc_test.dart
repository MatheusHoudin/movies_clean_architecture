import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_clean_architecture/features/movie_details/presentation/bloc/bloc.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
class GetMovieDetailsUsecaseMock extends Mock implements GetMovieDetailsUsecase {}
void main(){
  MovieDetailsBloc movieDetailsBloc;
  GetMovieDetailsUsecaseMock getMovieDetailsUsecase;
  MovieDetailsEntity tMoviesDetailsEntity = MovieDetailsEntity(
      productionCompanies: null,
      genres: null,
      belongsToCollection: null,
      voteAverage: 10.0,
      releaseDate: 'date',
      posterPath: 'poster',
      overview: 'overview',
      title: 'title',
      homepage: 'homepage',
      backdropPath: 'backdrop',
      adult: true,
      id: 1
  );
  final tMovieId = 1;
  setUp((){
    getMovieDetailsUsecase = GetMovieDetailsUsecaseMock();
    movieDetailsBloc = MovieDetailsBloc(getMovieDetailsUsecase: getMovieDetailsUsecase);
  });

  test(
    'should have the Loading as its initial state',
    () async {
      expect(movieDetailsBloc.initialState, Loading());
    }
  );

  test(
    'should call the GetMovieDetailsUsecase when the event is LoadMovieDetailsEvent',
    () async {
      movieDetailsBloc.add(LoadMovieDetailsEvent(movieId: tMovieId));

      await untilCalled(getMovieDetailsUsecase(any));
      verify(getMovieDetailsUsecase(Params(movieId: tMovieId)));
    }
  );

  test(
    'should return the MovieDetailsEntity when call to the usecase is successful',
    () async {
      when(getMovieDetailsUsecase(any))
      .thenAnswer((_) async => Right(tMoviesDetailsEntity));

      final expected = [
        Loading(),
        Loaded(movieDetailsEntity: tMoviesDetailsEntity)
      ];

      expectLater(movieDetailsBloc.cast(), emitsInOrder(expected));
      movieDetailsBloc.add(LoadMovieDetailsEvent(movieId: tMovieId));
    }
  );

  test(
    'should emit [Loading,Error] when getting remote data fails',
    () async {
      when(getMovieDetailsUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE)
      ];
      expectLater(movieDetailsBloc.cast(), emitsInOrder(expected));
      movieDetailsBloc.add(LoadMovieDetailsEvent(movieId: tMovieId));
    }
  );

  test(
    'should emit [Loading,Error] when getting local data fails',
    () async {
      when(getMovieDetailsUsecase(any))
      .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE)
      ];
      expectLater(movieDetailsBloc.cast(), emitsInOrder(expected));
      movieDetailsBloc.add(LoadMovieDetailsEvent(movieId: tMovieId));
    }
  );


}