// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/page_helper_test.dart';

void main() {
  late FakeTvSeriesListBloc fakeTVSeriesListBloc;
  late FakeTvSeriesPopularBloc fakeTVSeriesPopularBloc;
  late FakeTvSeriesTopRatedBloc fakeTVSeriesTopBloc;

  setUp(() {
    registerFallbackValue(FakeTvSeriesListEvent());
    registerFallbackValue(FakeTvSeriesListState());
    fakeTVSeriesListBloc = FakeTvSeriesListBloc();

    registerFallbackValue(FakeTvSeriesPopularEvent());
    registerFallbackValue(FakeTvSeriesPopularState());
    fakeTVSeriesPopularBloc = FakeTvSeriesPopularBloc();

    registerFallbackValue(FakeTvSeriesWatchlistEvent());
    registerFallbackValue(FakeTvSeriesWatchlistState());
    fakeTVSeriesTopBloc = FakeTvSeriesTopRatedBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvSeriesBloc>(
          create: (context) => fakeTVSeriesListBloc,
        ),
        BlocProvider<PopularTvSeriesBloc>(
          create: (context) => fakeTVSeriesPopularBloc,
        ),
        BlocProvider<TopRatedTvSeriesBloc>(
          create: (context) => fakeTVSeriesTopBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeTVSeriesListBloc.state)
        .thenReturn(NowPlayingTvSeriesLoading());
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(PopularTvSeriesLoading());
    when(() => fakeTVSeriesTopBloc.state).thenReturn(TopRatedTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TvSeriesListPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview tvlist when hasdata',
      (tester) async {
    when(() => fakeTVSeriesListBloc.state)
        .thenReturn(NowPlayingTvSeriesHasData(testTvSeriesList));
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(PopularTvSeriesHasData(testTvSeriesList));
    when(() => fakeTVSeriesTopBloc.state)
        .thenReturn(TopRatedTvSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);
    final tvListFinder = find.byType(TvSeriesList);

    await tester.pumpWidget(_createTestableWidget(const TvSeriesListPage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(tvListFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeTVSeriesListBloc.state)
        .thenReturn(NowPlayingTvSeriesError('error'));
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(PopularTvSeriesError('error'));
    when(() => fakeTVSeriesTopBloc.state)
        .thenReturn(TopRatedTvSeriesError('error'));

    await tester.pumpWidget(_createTestableWidget(const TvSeriesListPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('Page should display empty text when empty', (tester) async {
    when(() => fakeTVSeriesListBloc.state)
        .thenReturn(NowPlayingTvSeriesEmpty());
    when(() => fakeTVSeriesPopularBloc.state)
        .thenReturn(PopularTvSeriesEmpty());
    when(() => fakeTVSeriesTopBloc.state).thenReturn(TopRatedTvSeriesEmpty());

    await tester.pumpWidget(_createTestableWidget(const TvSeriesListPage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });
}
