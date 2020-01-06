import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'movie_poster.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
class MovieHeaderInfo extends StatelessWidget {
  final MovieDetailsEntity movieDetailsEntity;

  MovieHeaderInfo({this.movieDetailsEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.network('$moviePosterUrl${movieDetailsEntity.backdropPath}'),
          Positioned(
            bottom: 10,
            left: 15,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,

                      child: MoviePoster(imagePoster: movieDetailsEntity.posterPath,),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Movie Details')
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}