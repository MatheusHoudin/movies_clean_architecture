import 'package:flutter/material.dart';
import 'features/movies/presentation/pages/movies_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/movies/presentation/bloc/bloc.dart';
import 'injection_container.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController pageController = PageController(initialPage: 0);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<MoviesBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Movies Searcher'
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: <Widget>[
            MoviesPage(),
            Center(
              child: Text('another page'),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex = index;
              pageController.animateToPage(index, duration: Duration(milliseconds: 400),curve: Curves.easeInOut);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              title: Text('Movies')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              title: Text('TV Shows')
            )
          ],
        ),
      ),
    );
  }
}