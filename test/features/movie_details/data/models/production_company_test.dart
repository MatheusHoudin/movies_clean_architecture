import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/production_company_entity.dart';
import 'package:movies_clean_architecture/features/movie_details/data/models/production_company_model.dart';
void main() {

  final tProductionCompany = ProductionCompanyModel(
    id: 1,
    name: "company",
    logoPath: "logo",
    originCountry: "country"
  );

  test(
    'ProductionCompanyModel should be a subclass of ProductionCompany',
    () async {
      expect(tProductionCompany,isA<ProductionCompany>());
    }
  );

  test(
    'should convert the json and return the proper ProductionCompanyModel object',
    () async {
      final jsonMap = json.decode(fixture('production_company.json'));
      final result = ProductionCompanyModel.fromJson(jsonMap);

      expect(tProductionCompany,result);
    }
  );

  test(
    'should return proper json',
    () async {
      final expectedJson = {
        'id': 1,
        'name': 'company',
        'logo_path': 'logo',
        'origin_country': 'country'
      };
      final result = tProductionCompany.toJson();
      expect(expectedJson, result);
    }
  );
}