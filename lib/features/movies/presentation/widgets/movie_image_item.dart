import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
class MovieImageItem extends StatelessWidget {
  final Movie movie;

  MovieImageItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(side: BorderSide(width: 1,color: Colors.black)),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('$moviePosterUrl${movie.posterPath}'),
            fit: BoxFit.fill,
          )
        ),
      ),
    );
  }
}