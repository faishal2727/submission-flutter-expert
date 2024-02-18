

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/page_helper_test.dart';

void main() {
  late FakeTvSeriesDetailBloc fakeTvSeriesBloc;
  late FakeTvSeriesWatchlistBloc fakeWatchlistBloc;
  late FakeTvSeriesRecommendatioBloc fakeRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvSeriesDetailEvent());
    registerFallbackValue(FakeTvSeriesDetailState());
    fakeTvSeriesBloc = FakeTvSeriesDetailBloc();

    registerFallbackValue(FakeTvSeriesWatchlistEvent());
    registerFallbackValue(FakeTvSeriesWatchlistState());
    fakeWatchlistBloc = FakeTvSeriesWatchlistBloc();

    registerFallbackValue(FakeTvSeriesRecommendationEvent());
    registerFallbackValue(FakeTvSeriesRecommendatioState());
    fakeRecommendationBloc = FakeTvSeriesRecommendatioBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvSeriesBloc>(
          create: (context) => fakeTvSeriesBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<RecomendationTvSeriesBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvSeriesBloc>(
          create: (context) => fakeTvSeriesBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<RecomendationTvSeriesBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: body,
    );
  }

  // ignore: unused_local_variable
  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) =>
        _makeAnotherTestableWidget(DetailTvSeriesPage(id: 1)),
    DetailTvSeriesPage.ROUTE_NAME: (context) => const FakeDestination(),
  };

  testWidgets('should show circular progress when TV detail is loading',
      (tester) async {
    when(() => fakeTvSeriesBloc.state).thenReturn(DetailTvSeriesLoading());
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvSeriesLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(TvSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvSeriesPage(id: tTvSeriesDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message progress when TV detail is error',
      (tester) async {
    when(() => fakeTvSeriesBloc.state).thenReturn(DetailTvSeriesError('error'));
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvSeriesLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvSeriesPage(id: tTvSeriesDetail.id)));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('should show empty message progress when TV detail is empty',
      (tester) async {
    when(() => fakeTvSeriesBloc.state).thenReturn(DetailTvSeriesEmpty());
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvSeriesLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvSeriesIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvSeriesPage(id: tTvSeriesDetail.id)));

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when TV not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesBloc.state).thenReturn(DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvSeriesHasData(testTvSeriesList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvSeriesIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvSeriesPage(id: tTvSeriesDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when TV is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesBloc.state).thenReturn(DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvSeriesHasData(testTvSeriesList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvSeriesIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvSeriesPage(id: tTvSeriesDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}

class FakeHome extends StatelessWidget {
  const FakeHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeHome'),
        onTap: () {
          Navigator.pushNamed(context, '/next');
        },
      ),
      appBar: AppBar(
        title: const Text('fakeHome'),
        leading: const Icon(Icons.menu),
      ),
    );
  }
}

class FakeDestination extends StatelessWidget {
  const FakeDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeDestination'),
        onTap: () {
          Navigator.pop(context);
        },
        title: const Text('fake Destination'),
        leading: const Icon(Icons.check),
      ),
    );
  }
}