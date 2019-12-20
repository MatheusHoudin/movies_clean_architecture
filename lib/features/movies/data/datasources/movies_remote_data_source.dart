import 'dart:convert';

import 'package:movies_clean_architecture/core/error/exceptions.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:movies_clean_architecture/core/constants/texts.dart';
abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMoviesWithPage(int page);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;

  MoviesRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<MovieModel>> getMoviesWithPage(int page) async {
    final response = await client.get('${baseUrl}discover/movie?api_key=$apiKey&sort_by=popularity.desc&page=$page');
    if(response.statusCode == 200){
      Map<String,dynamic> result = json.decode(response.body);

      return (result['results'] as List).map((i) => MovieModel.fromJson(i)).toList();
    }else{
      throw ServerException();
    }
  }
}