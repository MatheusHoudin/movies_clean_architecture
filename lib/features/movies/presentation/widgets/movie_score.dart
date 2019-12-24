import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/core/constants/colors.dart';
class MovieScore extends StatelessWidget {
  final String score;
  final double padding;
  final double borderWidth;
  final double textSize;

  MovieScore({this.score,this.padding,this.borderWidth,this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: scoreBackground,
        shape: BoxShape.circle,
        border: Border.all(color: brightGreen, width: borderWidth)
      ),
      child: Text(
        score,
        style: TextStyle(
          fontSize: textSize,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}