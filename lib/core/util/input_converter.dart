import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/error/failures.dart';

class InputConverter {
  Either<Failure,int> stringToUnsignedInt(String str){
    try {
      if(str == null) throw FormatException();
      int value = int.parse(str);
      if(value < 0) throw FormatException();
      return Right(value);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];
}