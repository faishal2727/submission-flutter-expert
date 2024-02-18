
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesBloc tvseriesBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvseriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvseriesBloc.state, TopRatedTvSeriesEmpty());
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvSeriesEvent()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
      return OnTopRatedTvSeriesEvent().props;
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvSeriesEvent()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvSeriesLoading(),
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvSeriesEvent()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesEmpty(),
    ],
  );
}