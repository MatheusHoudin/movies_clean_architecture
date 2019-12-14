import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_clean_architecture/features/movies/domain/usecases/get_movies_with_page_usecase.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  GetMoviesWithPageUsecase getMoviesWithPageUsecase;
  MockMoviesRepository mockMoviesRepository;
  final movies = [
    Movie(id: 1,title: 'title1',adult: true,genreIds: [1],overview: 'overview',posterPath: 'path',releaseDate: 'date',voteAverage: 10),
    Movie(id: 2,title: 'title2',adult: true,genreIds: [2],overview: 'overview2',posterPath: 'path2',releaseDate: 'date2',voteAverage: 10),
  ];
  setUp((){
    mockMoviesRepository = MockMoviesRepository();
    getMoviesWithPageUsecase = GetMoviesWithPageUsecase(mockMoviesRepository);
  });

  test(
    'should get movies list from the repository',
    () async {
      when(mockMoviesRepository.getMoviesWithPage(any))
      .thenAnswer((_) async => Right(movies));

      final result = await getMoviesWithPageUsecase(Params(page: 1));

      expect(result, Right(movies));
      verify(mockMoviesRepository.getMoviesWithPage(1));
      verifyNoMoreInteractions(mockMoviesRepository);
    }
  );

}