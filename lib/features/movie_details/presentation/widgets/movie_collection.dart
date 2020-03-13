import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/belongs_to_collection_entity.dart';
import 'movie_poster.dart';
import 'package:movies_clean_architecture/core/constants/colors.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
class MovieCollection extends StatelessWidget {
  final BelongsToCollection belongsToCollection;

  MovieCollection({this.belongsToCollection});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network('$moviePosterUrl${belongsToCollection.backdropPath}',fit: BoxFit.cover,),
              Container(
                color: brightGreenWithTransparency,
                padding: EdgeInsets.only(left: 20,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Part of the ${belongsToCollection.name} collection',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            'Includes movie 1, movie 2, movie 3',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.red,
                        child: RawMaterialButton(
                          onPressed: () => print('teste'),
                          fillColor: brightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                          child: Container(
                            height: 20,
                            color: Colors.black,
                            child: Text(
                              'VIEW THE COLLECTION',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

}