import 'package:flutter/material.dart';

class MovieSectionTitle extends StatelessWidget {
  final String sectionTitle;

  MovieSectionTitle({this.sectionTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.sectionTitle,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22
      )
    );
  }
}