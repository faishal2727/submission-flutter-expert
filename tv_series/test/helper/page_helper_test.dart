import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

void main() {
  setUp(() {
    registerFallbackValue(FakeTvSeriesListEvent());
    registerFallbackValue(FakeTvSeriesListState());
    registerFallbackValue(FakeTvSeriesPopularEvent());
    registerFallbackValue(FakeTvSeriesPopularState());
    registerFallbackValue(FakeTvSeriesTopRatedEvent());
    registerFallbackValue(FakeTvSeriesTopRatedState());
    TestWidgetsFlutterBinding.ensureInitialized();
  });
}

class FakeTvSeriesListEvent extends Fake implements NowPlayingTvSeriesEvent {}
class FakeTvSeriesListState extends Fake implements NowPlayingTvSeriesState {}
class FakeTvSeriesListBloc extends MockBloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> implements NowPlayingTvSeriesBloc {}


class FakeTvSeriesPopularEvent extends Fake implements PopularTvSeriesEvent {}
class FakeTvSeriesPopularState extends Fake implements PopularTvSeriesState {}
class FakeTvSeriesPopularBloc extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState> implements PopularTvSeriesBloc {}

class FakeTvSeriesTopRatedEvent extends Fake implements TopRatedTvSeriesEvent {}
class FakeTvSeriesTopRatedState extends Fake implements TopRatedTvSeriesState {}
class FakeTvSeriesTopRatedBloc extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> implements TopRatedTvSeriesBloc {}

class FakeTvSeriesDetailEvent extends Fake implements DetailTvSeriesEvent {}
class FakeTvSeriesDetailState extends Fake implements DetailTvSeriesState {}
class FakeTvSeriesDetailBloc extends MockBloc<DetailTvSeriesEvent, DetailTvSeriesState> implements DetailTvSeriesBloc {}

class FakeTvSeriesWatchlistEvent extends Fake implements WatchlistTvSeriesEvent {}
class FakeTvSeriesWatchlistState extends Fake implements WatchlistTvSeriesState {}
class FakeTvSeriesWatchlistBloc extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> implements WatchlistTvSeriesBloc {}

class FakeTvSeriesRecommendationEvent extends Fake implements RecomendationTvSeriesEvent {}
class FakeTvSeriesRecommendatioState extends Fake implements RecomendationTvSeriesState {}
class FakeTvSeriesRecommendatioBloc extends MockBloc<RecomendationTvSeriesEvent, RecomendationTvSeriesState> implements RecomendationTvSeriesBloc {}

