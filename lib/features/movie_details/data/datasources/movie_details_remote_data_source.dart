import '../models/movie_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetailsModel> getMovieDetailsModel(int movieId);
}

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final http.Client client;

  MovieDetailsRemoteDataSourceImpl({@required this.client});

  @override
  Future<MovieDetailsModel> getMovieDetailsModel(int movieId) async {
    print('Movie Id ${movieId}');
    final result = await client.get('${baseUrl}movie/$movieId?api_key=$apiKey');
    if(result.statusCode == 200) {
      return MovieDetailsModel.fromJson(json.decode(result.body));
    }else{
      throw ServerException();
    }
  }
}