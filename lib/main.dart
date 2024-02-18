import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

void main() async {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // package: search
        BlocProvider(create: (_) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvSeriesBloc>()),

        //package: movie
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider<PopularMovieBloc>(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider<TopRatedMovieBloc>(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<RecomendationMovieBloc>()),

        //package: tv-series
        BlocProvider(create: (_) => di.locator<NowPlayingTvSeriesBloc>()),
        BlocProvider<PopularTvSeriesBloc>(create: (_) => di.locator<PopularTvSeriesBloc>()),
        BlocProvider<TopRatedTvSeriesBloc>(create: (_) => di.locator<TopRatedTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<DetailTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<RecomendationTvSeriesBloc>()),

        //packege: watclist
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvSeriesBloc>()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTES:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_SERIES_DETAIL_ROUTES:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailTvSeriesPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIE_ROUTES:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WATCHLIST_MOVIE_ROUTES:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WATCHLIST_ROUTES:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case NowPlayingTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => NowPlayingTvSeriesPage());
            case TvSeriesListPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSeriesListPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case SEARCH_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchTvSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
