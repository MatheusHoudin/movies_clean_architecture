import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_clean_architecture/core/constants/colors.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/belongs_to_collection_entity.dart';
import 'package:movies_clean_architecture/features/movie_details/domain/entities/production_company_entity.dart';
import '../widgets/movie_header_info.dart';
import '../widgets/movie_genre.dart';
import '../widgets/movie_section_title.dart';
import '../widgets/movie_collection.dart';
import '../widgets/movie_company.dart';
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
                  SizedBox(height: 10,),
                  state.movieDetailsEntity.belongsToCollection != null ?
                      CollectionSection(state.movieDetailsEntity.belongsToCollection)
                      :
                      Container(),
                  SizedBox(height: 10,),
                  state.movieDetailsEntity.productionCompanies != null ?
                      CompaniesSection(state.movieDetailsEntity.productionCompanies,context)
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,

          height: MediaQuery.of(context).size.height * 0.3,
          child: MovieCollection(
            belongsToCollection: belongsToCollection,
          ),
        )
      ],
    );
  }

  Widget CompaniesSection(List<ProductionCompany> companies,BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(36),topRight: Radius.circular(36))
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: MovieSectionTitle(sectionTitle: 'Production Companies',textColor: Colors.white,),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              child: ListView.builder(
                itemCount: companies.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,i)
                => Container(
                  margin: EdgeInsets.only(right: 16),
                  child: MovieCompany(productionCompany: companies[i],),
                ),
              ),
            )
          ],
        ),
      ),
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