import 'failures.dart';
import '../constants/texts.dart';

String chooseErrorMessage(Failure failure){
  switch(failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE;
    case CacheFailure:
      return CACHE_FAILURE;
    default:
      return 'An unexpected error has ocurred';
  }
}