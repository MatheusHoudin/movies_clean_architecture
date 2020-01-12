import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
class MovieBackdrop extends StatelessWidget {
  final String movieBackdropPath;

  MovieBackdrop({this.movieBackdropPath});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Image.network('$moviePosterUrl$movieBackdropPath',fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
      clipper: BackdropClipper(),
    );
  }
}

class BackdropClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}