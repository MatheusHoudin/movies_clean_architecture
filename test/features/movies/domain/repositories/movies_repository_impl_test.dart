import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_local_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';
import 'package:movies_clean_architecture/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';

class MockMoviesRemoteDataSource extends Mock implements MoviesRemoteDataSource{}
class MockMoviesLocalDataSource extends Mock implements MoviesLocalDataSource{}
class MockNetworkInfo extends Mock implements NetworkInfo{}

main() {
  MoviesRepositoryImpl moviesRepositoryImpl;
  MockMoviesRemoteDataSource moviesRemoteDataSource;
  MockMoviesLocalDataSource moviesLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    moviesLocalDataSource = MockMoviesLocalDataSource();
    moviesRemoteDataSource = MockMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    moviesRepositoryImpl = MoviesRepositoryImpl(
      moviesLocalDataSource: moviesLocalDataSource,
      moviesRemoteDataSource: moviesRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('device is online', () {
    final tMovieModel = MovieModel(
      id: 1,
      adult: true,
      overview: "overview",
      posterPath: 'poster.png',
      releaseDate: '2019-10-10',
      title: 'title',
      voteAverage: 9.0,
      genreIds: [1,2,3]
    );
    final Movie tMovie = tMovieModel;

    int page = 1 ;
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test(
      'should check if the device is online',
      () async {
        moviesRepositoryImpl.getMoviesWithPage(page);

        verify(mockNetworkInfo.isConnected);
      }
    );

   /* test(
      'should return remote data when call to remote data source is successful',
      () async {
         when(moviesRemoteDataSource.getMoviesWithPage(page))
         .thenAnswer((_) async => [tMovieModel]);

         moviesRepositoryImpl.getMoviesWithPage(page);

         verify(moviesRemoteDataSource.getMoviesWithPage(page));
         
      }
    );*/
   
  });
  
  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test(
      'should check if the device is offnline',
      () async {
        moviesRepositoryImpl.getMoviesWithPage(1);

        verify(mockNetworkInfo.isConnected);
      }
    );
  });
}