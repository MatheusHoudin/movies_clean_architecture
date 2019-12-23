import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(4),bottomLeft: Radius.circular(4)),
                image: DecorationImage(
                  image: NetworkImage('$moviePosterUrl${this.movie.posterPath}'),
                  fit: BoxFit.fill
                )
              )
            ),
          ),
          Expanded(
            flex: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        movie.title,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      movie.voteAverage.toString()
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      movie.overview,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}