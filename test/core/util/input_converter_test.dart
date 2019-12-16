import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_architecture/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  test(
    'should return the right side containing an int when the conversion is successful',
    () async {
      final String str = '123';

      final result = inputConverter.stringToUnsignedInt(str);

      expect(result, Right(123));      
    }
  );

  test(
    'should return the left side when the number is less than zero',
    () async {
      final String str = '-123';

      final result = inputConverter.stringToUnsignedInt(str);

      expect(result, Left(InvalidInputFailure()));  
    }
  );

  test(
    'should return the left side when the string is not a number',
    () async {
      final String str = 'abc';

      final result = inputConverter.stringToUnsignedInt(str);

      expect(result, Left(InvalidInputFailure()));  
    }
  );

  test(
    'should return the left side when the string is null',
    () async {
      final String str = null;

      final result = inputConverter.stringToUnsignedInt(str);

      expect(result, Left(InvalidInputFailure()));  
    }
  );
}