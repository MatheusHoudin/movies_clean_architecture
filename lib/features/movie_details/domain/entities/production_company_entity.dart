import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ProductionCompany extends Equatable {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    @required this.id,
    @required this.logoPath,
    @required this.name,
    @required this.originCountry
  });

  @override
  List<Object> get props => [
    id,
    name,
    logoPath,
    originCountry
  ];

}