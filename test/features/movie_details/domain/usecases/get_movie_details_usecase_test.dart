import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/repositories/movie_details_repository.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/usecases/get_movie_details_usecase.dart';
class MovieDetailsRepositoryMock extends Mock implements MovieDetailsRepository {}

void main() {
  MovieDetailsRepositoryMock repositoryMock;
  GetMovieDetailsUsecase getMovieDetailsUsecase;
  MovieDetailsEntity detailsEntity = MovieDetailsEntity(
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
  setUp((){
    repositoryMock = MovieDetailsRepositoryMock();
    getMovieDetailsUsecase = GetMovieDetailsUsecase(movieDetailsRepository: repositoryMock);
  });

  test('should return the movie details when call to the usecase is successful',
    () async {
      when(repositoryMock.getMovieDetails(any)).thenAnswer((_) async => Right(detailsEntity));

      final result = await getMovieDetailsUsecase(Params(movieId: 1));

      verify(repositoryMock.getMovieDetails(1));
      expect(Right(detailsEntity), result);
    }
  );

  test('should return a Failure when call to movie details is unsuccessful',
    () async {
      when(repositoryMock.getMovieDetails(any)).thenAnswer((_) async => Left(ServerFailure()));

      final result = await getMovieDetailsUsecase(Params(movieId: 1));

      verify(repositoryMock.getMovieDetails(1));
      expect(Left(ServerFailure()), result);
    }
  );
}

