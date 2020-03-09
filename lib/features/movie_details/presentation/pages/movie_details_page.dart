import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/belongs_to_collection_entity.dart';
import '../widgets/movie_header_info.dart';
import '../widgets/movie_genre.dart';
import '../widgets/movie_section_title.dart';
import '../widgets/movie_collection.dart';
import 'package:movies_clean_architecture/features/movie_details/presentation/bloc/bloc.dart';
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
      backgroundColor: Colors.white,
      body: BlocBuilder<MovieDetailsBloc,MovieDetailsState>(
        builder: (context,state) {
          if( state is Loading ){
            return LoadingMovieDetails();
          }else if( state is Error ){
            return LoadingMovieDetailsError(state.message);
          }else if( state is Loaded ){
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.54,
                    child: MovieHeaderInfo(
                      movieDetailsEntity: state.movieDetailsEntity,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      state.movieDetailsEntity.overview,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                           child: MovieSectionTitle(sectionTitle: 'Similar Genres',)
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.movieDetailsEntity.genres.length,
                            itemBuilder: (context,i)
                            => Container(
                              margin: EdgeInsets.only(right: 10),
                              child: MovieGenre(genre: state.movieDetailsEntity.genres[i],),
                            ),
                          ),
                        ),
                      ],
                      
                    ),
                  ),
                  state.movieDetailsEntity.belongsToCollection != null ?
                        CollectionSection(state.movieDetailsEntity.belongsToCollection)
                        :
                        Container()
                ],
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

  Widget CollectionSection(BelongsToCollection belongsToCollection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MovieSectionTitle(sectionTitle: 'Collection',)
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.3,
          child: MovieCollection(
            belongsToCollection: belongsToCollection,
          ),
        )
      ],
    );
  }

  Widget LoadingMovieDetails() {
    return Center(
      child: CircularProgressIndicator(),
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