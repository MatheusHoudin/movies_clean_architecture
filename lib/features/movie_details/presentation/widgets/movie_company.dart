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
      child: Padding(
        padding: EdgeInsets.all(4),
        child: productionCompany.logoPath != null ? CompanyDataWithImage() : CompanyDataWithoutImage(),
      ),
    );
  }

  Widget CompanyDataWithoutImage(){
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: CompanyName(),
          ),
        )
      ],
    );
  }

  Widget CompanyDataWithImage(){
    return Column(
      children: <Widget>[
        Expanded(flex: 3,child: CompanyImage()),
        SizedBox(height: 4,),
        Expanded(flex: 1,child: CompanyName())
      ],
    );
  }

  Widget CompanyImage() {
    return Card(
      shape: CircleBorder(),
      color: brightGreen,
      child: Container(
        height: 30,
        width: 30,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(

            image: DecorationImage(
              image: NetworkImage('$moviePosterUrl${productionCompany.logoPath}'),
            )
        ),
      ),
    );
  }

  Widget CompanyName(){
    return Center(
      child: Container(
        child: Text(
          productionCompany.name,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

}