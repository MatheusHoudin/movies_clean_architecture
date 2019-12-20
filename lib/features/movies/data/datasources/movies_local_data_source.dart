import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
abstract class MoviesLocalDataSource {
  Future<List<MovieModel>> getLastMovies();
  Future<void> cacheMovies(List<MovieModel> movies); 
}

const CACHED_MOVIES = 'cached_movies';

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final Box moviesBox;

  MoviesLocalDataSourceImpl({
    @required this.moviesBox
  });

  @override
  Future<void> cacheMovies(List<MovieModel> movies) {
    return Future<void>.value(moviesBox.addAll(movies));
  }

  @override
  Future<List<MovieModel>> getLastMovies() {
    final result = moviesBox.get(CACHED_MOVIES);
    if(result != null) {
      return Future.value(result);
    }else{
      throw CacheException();
    }
  }

}