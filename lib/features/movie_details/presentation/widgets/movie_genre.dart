import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/genre_entity.dart';
class MovieGenre extends StatelessWidget {
  final Genre genre;

  MovieGenre({this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Center(
        child: Text(
          genre.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

}