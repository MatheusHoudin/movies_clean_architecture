import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/get_movies_bloc/bloc.dart';
import 'package:movies_clean_architecture/features/movies/presentation/bloc/change_movies_view_bloc/bloc.dart';
import 'package:movies_clean_architecture/features/movies/presentation/widgets/movie_item.dart';
import 'package:movies_clean_architecture/core/constants/colors.dart';
import 'package:movies_clean_architecture/features/movies/presentation/widgets/movie_image_item.dart';
import '../../../../injection_container.dart';
import 'package:movies_clean_architecture/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:movies_clean_architecture/features/movie_details/presentation/bloc/bloc.dart' as MovieDetailsBloc;
class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  ScrollController _scrollController = ScrollController();
  bool isDetailedMoviesView;
  @override
  void initState() {
    super.initState();
    isDetailedMoviesView = true;
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        BlocProvider.of<MoviesBloc>(context).add(GetMoviesWithPageEvent());
      }
    });
    BlocProvider.of<MoviesBloc>(context).add(GetMoviesWithPageEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: (){
          BlocProvider.of<ChangeMoviesViewBloc>(context).add(ChangeMoviesViewEvent());
        },
        child: BlocBuilder<ChangeMoviesViewBloc,ChangeMoviesViewState>(
          builder: (context,state) {
            return Icon(
              state is MoviesWithDescriptionState ? Icons.apps : Icons.art_track,
              color: brightGreen
            );
          },
        )
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is Empty) {
              return Center(
                child: Text('There is no movies'),
              );
            } else if (state is Loading) {
              return LoadingMovies();
            } else if (state is Error) {
              return Center(
                child: Text('There was an error: ${state.message}'),
              );
            } else if (state is Loaded) {
              return MoviesList(state.movies,false);
            }else if(state is LoadingMore) {
              return MoviesList(state.previousMovies,true);
            }
            return Center(
              child: Text('EMPTY'),
            );
          },
      ),
    );
  }

  Widget MoviesList(List<Movie> movies,bool loadingMore) {
    return BlocBuilder<ChangeMoviesViewBloc,ChangeMoviesViewState>(
      builder: (context,state){
        return state is MoviesWithDescriptionState ?
        MoviesScrollView(movies, loadingMore)
            :
        MoviesWrap(movies, loadingMore);
      },
    );
  }

  Widget MoviesScrollView(List<Movie> movies,bool loadingMore) {
    return ListView.builder(
      itemCount: loadingMore ? movies.length + 1 : movies.length,
      controller: _scrollController,
      itemBuilder: (context,index) {
        return index >= movies.length ? LoadingMovies() : MovieDetailsWidget(movies[index]);
      },
    );
  }

  Widget MoviesWrap(List<Movie> movies,bool loadingMore) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 4),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Wrap(
          runSpacing: 4,
          spacing: 4,
          children: _getWrapMovies(movies, loadingMore),
        ),
      ),
    );
  }

  List<Widget> _getWrapMovies(List<Movie> movies,bool loadingMore) {
    List<Widget> widgetsList = List();
    for(Movie m in movies) {
      widgetsList.add(MovieImageOnlyWidget(m));
    }
    if(loadingMore) widgetsList.add(LoadingMovies());
    return widgetsList;
  }
  
  Widget LoadingMovies() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget MovieDetailsWidget(Movie movie) {

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => BlocProvider(
          builder: (_) => sl<MovieDetailsBloc.MovieDetailsBloc>(),
          child: MovieDetailsPage(movieId: movie.id,),
        )
      )),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Container(
          margin: EdgeInsets.all(4),
          child: MovieItem(
            movie: movie,
          ),
        ),
      ),
    );
  }

  Widget MovieImageOnlyWidget(Movie movie) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => BlocProvider(
            builder: (_) => sl<MovieDetailsBloc.MovieDetailsBloc>(),
            child: MovieDetailsPage(movieId: movie.id,),
          )
      )),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.32,
        child: MovieImageItem(movie: movie,),
      ),
    );
  }
}
