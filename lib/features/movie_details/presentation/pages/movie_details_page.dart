import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  MovieDetailsPage({this.movieId});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        movieId.toString()
      ),
    );
  }
}