
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/page_helper_test.dart';

void main() {
  late FakeTvSeriesTopRatedBloc fakeBloc;

  setUp(() {
    registerFallbackValue(FakeTvSeriesTopRatedEvent());
    registerFallbackValue(FakeTvSeriesTopRatedState());
    fakeBloc = FakeTvSeriesTopRatedBloc();
  });

  Widget createTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>(
      create: (context) => fakeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TopRatedTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(createTestableWidget( TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeBloc.state)
        .thenReturn(TopRatedTvSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester
        .pumpWidget(createTestableWidget(const TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

    testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeBloc.state)
        .thenReturn( TopRatedTvSeriesHasData([tTvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(createTestableWidget(const TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });


  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeBloc.state)
        .thenReturn( TopRatedTvSeriesError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(createTestableWidget(const TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}