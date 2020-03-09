import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/core/constants/colors.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import 'movie_poster.dart';
import 'movie_backdrop.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
class MovieHeaderInfo extends StatelessWidget {
  final MovieDetailsEntity movieDetailsEntity;

  MovieHeaderInfo({this.movieDetailsEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              MovieBackdrop(movieBackdropPath: movieDetailsEntity.backdropPath,),
              Positioned(
                bottom: -MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  padding: EdgeInsets.only(left: 10),

                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: MoviePoster(imagePoster: movieDetailsEntity.posterPath,),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.only(left: 10,top: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MovieTitle(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      VoteAverage(),
                      ReleaseDate(),
                      Adult(movieDetailsEntity.adult),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget Adult(bool isAdultMovie) {
    return Container(
      padding: EdgeInsets.only(top: 6,bottom: 6,left: 8,right: 8),
      decoration: BoxDecoration(
        color: isAdultMovie ? Colors.redAccent : brightGreen,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Text(
        isAdultMovie ? '+18' : 'L',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget MovieTitle() {
    return Text(
      movieDetailsEntity.title,
      maxLines: 3,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget VoteAverage() {
    return Column(
      children: <Widget>[
        Text(
          movieDetailsEntity.voteAverage.toString(),
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          'Ratings',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16
          ),
        )
      ],
    );
  }

  Widget ReleaseDate() {
    return Text(
      movieDetailsEntity.releaseDate,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16
      ),
    );
  }
}
