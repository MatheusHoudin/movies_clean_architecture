import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_clean_architecture/injection_container.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/bloc.dart';
class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(GetMoviesWithPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesBloc,MoviesState>(
        builder: (context,state){
          if( state is Empty ){
            return Center(
              child: Text('There is no movies'),
            );
          }else if( state is Loading ){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if( state is Error ) {
            return Center(
              child: Text('There was an error: ${state.message}'),
            );
          }else if( state is Loaded ) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context,index) => Text(state.movies[index].title),
            );
          }
          return Center(
            child: Text('EMPTY'),
          );
        },
      )
    );
  }
}