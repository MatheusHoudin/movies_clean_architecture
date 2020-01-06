import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
class MoviePoster extends StatelessWidget {
  final String imagePoster;

  MoviePoster({this.imagePoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        image: DecorationImage(
          image: NetworkImage('$moviePosterUrl$imagePoster'),
          fit: BoxFit.fill
        )
      ),
    );
  }
}