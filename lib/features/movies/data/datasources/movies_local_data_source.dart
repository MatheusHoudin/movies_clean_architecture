import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';

abstract class MoviesLocalDataSource {
  Future<MovieModel> getLastMovies(); 
}