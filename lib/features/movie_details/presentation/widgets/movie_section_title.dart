import 'package:flutter/material.dart';

class MovieSectionTitle extends StatelessWidget {
  final String sectionTitle;
  final Color textColor;

  MovieSectionTitle({this.sectionTitle,this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.sectionTitle,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor,
        fontSize: 24
      )
    );
  }
}