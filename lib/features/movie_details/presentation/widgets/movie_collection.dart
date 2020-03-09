import 'package:flutter/material.dart';
import '../../domain/entities/belongs_to_collection_entity.dart';
import 'movie_poster.dart';
class MovieCollection extends StatelessWidget {
  final BelongsToCollection belongsToCollection;

  MovieCollection({this.belongsToCollection});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: MoviePoster(
            imagePoster: belongsToCollection.posterPath,
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(belongsToCollection.name),
        )
      ],
    );
  }

}