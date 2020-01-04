import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_local_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:movies_clean_architecture/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_clean_architecture/features/movies/domain/usecases/get_movies_with_page_usecase.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/get_movies_bloc/bloc.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/change_movies_view_bloc/bloc.dart';
import 'features/movie_details/presentation/bloc/movie_details_bloc.dart';
import 'package:http/http.dart' as http;
final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => MoviesBloc(getMoviesWithPageUsecase: sl()));
  sl.registerFactory(() => ChangeMoviesViewBloc());
  sl.registerFactory(() => MovieDetailsBloc());

  sl.registerLazySingleton<GetMoviesWithPageUsecase>(() => GetMoviesWithPageUsecase(sl()));

  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      moviesLocalDataSource: sl(),
      moviesRemoteDataSource: sl(),
      networkInfo: sl()
    )
  );

  sl.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(client: sl())
  );
  sl.registerLazySingleton<MoviesLocalDataSource>(
    () => MoviesLocalDataSourceImpl(moviesBox: sl())
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl())
  );

  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final moviesBox = await Hive.openBox('movies');
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  sl.registerLazySingleton(() => moviesBox);
}