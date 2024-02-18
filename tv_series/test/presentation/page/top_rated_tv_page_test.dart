import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';
import '../../dummy_data/dummy_object.dart';

class MockTopRatedTvSeriessBloc
    extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

class FakeTopRatedTvSeriessEvent extends Fake implements TopRatedTvSeriesEvent {}

class FakeTopRatedTvSeriessState extends Fake implements TopRatedTvSeriesState {}

void main() {
  late MockTopRatedTvSeriessBloc mockTopRatedTvSeriessBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvSeriessEvent());
    registerFallbackValue(FakeTopRatedTvSeriessState());
  });

  setUp(() {
    mockTopRatedTvSeriessBloc = MockTopRatedTvSeriessBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>.value(
      value: mockTopRatedTvSeriessBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriessBloc.state)
        .thenReturn(TopRatedTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriessBloc.state)
        .thenReturn(TopRatedTvSeriesHasData( [tTvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriessBloc.state)
        .thenReturn(TopRatedTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}

