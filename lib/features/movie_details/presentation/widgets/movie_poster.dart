import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
class MoviePoster extends StatelessWidget {
  final String imagePoster;

  MoviePoster({this.imagePoster});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network('$moviePosterUrl$imagePoster',fit: BoxFit.fill,),
    );

  }
}