import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:watchlist/watchlist.dart';


void main() {
  setUp(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
    TestWidgetsFlutterBinding.ensureInitialized();
  });
}

class FakeMovieListEvent extends Fake implements NowPlayingMovieEvent {}
class FakeMovieListState extends Fake implements NowPlayingMovieState {}
class FakeMovieListBloc extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState> implements NowPlayingMovieBloc {}


class FakePopularMovieEvent extends Fake implements PopularMovieEvent {}
class FakePopularMovieState extends Fake implements PopularMovieState {}
class FakePopularMovieBloc extends MockBloc<PopularMovieEvent, PopularMovieState> implements PopularMovieBloc {}


class FakeTopRatedMovieEvent extends Fake implements TopRatedMovieEvent {}
class FakeTopRatedMovieState extends Fake implements TopRatedMovieState {}
class FakeTopRatedMovieBloc extends MockBloc<TopRatedMovieEvent, TopRatedMovieState> implements TopRatedMovieBloc {}

class FakeMovieDetailEvent extends Fake implements DetailMovieEvent {}
class FakeMovieDetailState extends Fake implements DetailMovieState {}
class FakeMovieDetailBloc extends MockBloc<DetailMovieEvent, DetailMovieState> implements DetailMovieBloc {}

class FakeRecommendationMovieEvent extends Fake implements RecomendationMovieEvent {}
class FakeRecommendationMovieState extends Fake implements RecomendationMovieState {}
class FakeRecommendationMovieBloc extends MockBloc<RecomendationMovieEvent, RecomendationMovieState> implements RecomendationMovieBloc {}

class FakeMovieWatchlistEvent extends Fake implements WatchlistMovieEvent {}
class FakeMovieWatchlistState extends Fake implements WatchlistMovieState {}
class FakeMovieWatchlistBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState> implements WatchlistMovieBloc {}
