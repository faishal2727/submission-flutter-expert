
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesBloc tvseriesBloc;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    tvseriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvseriesBloc.state, NowPlayingTvSeriesEmpty());
  });

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
      return OnNowPlayingTvSeriesEvent().props;
    },
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTvSeriesLoading(),
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesEmpty(),
    ],
  );
}