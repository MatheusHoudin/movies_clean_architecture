import 'package:movies_clean_architecture/features/movie_details/data/models/movie_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
abstract class MovieDetailsLocalDataSource {
  Future<void> cacheMovieDetails(MovieDetailsModel movieDetailsModel);
  Future<MovieDetailsModel> getCachedMovieDetails(int movieId);
}

class MovieDetailsLocalDataSourceImpl implements MovieDetailsLocalDataSource {
  final SharedPreferences preferences;

  MovieDetailsLocalDataSourceImpl({@required this.preferences});

  @override
  Future<void> cacheMovieDetails(MovieDetailsModel movieDetailsModel) {
    print(movieDetailsModel.toJson().toString());
    return preferences.setString(movieDetailsModel.id.toString(), movieDetailsModel.toJson().toString());
  }

  @override
  Future<MovieDetailsModel> getCachedMovieDetails(int movieId) {
    final cachedMovie = preferences.get(movieId.toString());
    return Future.value(MovieDetailsModel.fromJson(json.decode(cachedMovie)));
  }

}