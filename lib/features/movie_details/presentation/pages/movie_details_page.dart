import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/movie_header_info.dart';
import 'package:movies_clean_architecture/core/constants/colors.dart';
import 'package:movies_clean_architecture/features/movie_details/presentation/bloc/bloc.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/movie_details_entity.dart';
class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  MovieDetailsPage({this.movieId});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  @override
  void initState() {
    BlocProvider.of<MovieDetailsBloc>(context).add(GetMovieDetailsEvent(movieId: this.widget.movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsBloc,MovieDetailsState>(
        builder: (context,state) {
          if( state is Loading ){
            return LoadingMovieDetails();
          }else if( state is Error ){
            return LoadingMovieDetailsError(state.message);
          }else if( state is Loaded ){
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: MovieHeaderInfo(
                        movieDetailsEntity: state.movieDetailsEntity,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: 50,
                        height: 50,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Text('undefined error'),
          );
        },
      ),
    );
  }

  Widget LoadingMovieDetails() {
    return Center(
      child: CircularProgressIndicator(backgroundColor: brightGreen,),
    );
  }

  Widget LoadingMovieDetailsError(String errorMessage) {
    return Center(
      child: Text(
        errorMessage
      ),
    );
  }
}