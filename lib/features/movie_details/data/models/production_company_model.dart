import 'package:meta/meta.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/production_company_entity.dart';
class ProductionCompanyModel extends ProductionCompany {

  ProductionCompanyModel({
    @required int id,
    @required String name,
    @required String logoPath,
    @required String originCountry
  }) : super(id: id,name:name,logoPath:logoPath,originCountry:originCountry);

  factory ProductionCompanyModel.fromJson(Map<String,dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'],
      name: json['name'],
      logoPath: json['logo_path'],
      originCountry: json['origin_country']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id': this.id,
      'name': this.name,
      'logo_path': this.logoPath,
      'origin_country': this.originCountry
    };
  }

  @override
  String toString() {
    return {
      'id': this.id,
      'name': this.name,
      'logo_path': this.logoPath,
      'origin_country': this.originCountry
    }.toString();
  }
}