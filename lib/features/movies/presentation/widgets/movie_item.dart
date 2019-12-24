import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'package:movies_clean_architecture/features/movies/presentation/widgets/movie_score.dart';
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
            flex: 7,
            child: MovieImage(),
          ),
          Expanded(
            flex: 12,
            child: MovieDetails()
          )
        ],
      )
    );
  }

  Widget MovieImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(4),bottomLeft: Radius.circular(4)),
        image: DecorationImage(
          image: NetworkImage('$moviePosterUrl${this.movie.posterPath}'),
          fit: BoxFit.fill
        )
      ),
    );
  }

  Widget MovieDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MovieTitle(),
            Container(
              margin: EdgeInsets.all(8),
              child: MovieScore(
                padding: 8,
                borderWidth: 3,
                textSize: 16,
                score: this.movie.voteAverage.toString(),
              ),
            )
          ],
        ),
        Expanded(
            child: MovieDescription()
        )
      ],
    );
  }

  Widget MovieTitle() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          movie.title,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget MovieDescription() {
    return Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.bottomCenter,
        child: Text(
          movie.overview,
          maxLines: 5,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
          ),
        )
    );
  }

}