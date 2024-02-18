
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesBloc tvseriesBloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvseriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvseriesBloc.state, PopularTvSeriesEmpty());
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvSeriesEvent()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
      return OnPopularTvSeriesEvent().props;
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvSeriesEvent()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => PopularTvSeriesLoading(),
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvSeriesEvent()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesEmpty(),
    ],
  );
}