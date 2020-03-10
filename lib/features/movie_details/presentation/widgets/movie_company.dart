import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/core/constants/texts.dart';
import '../../domain/entities/production_company_entity.dart';
import '../../../../core/constants/colors.dart';
class MovieCompany extends StatelessWidget {
  final ProductionCompany productionCompany;

  MovieCompany({this.productionCompany});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$moviePosterUrl${productionCompany.logoPath}'),
              )
            ),
          ),
          Center(
            child: Text(
              productionCompany.name,
              style: TextStyle(
                color: brightGreen
              ),
            ),
          )
        ],
      ),
    );
  }

}