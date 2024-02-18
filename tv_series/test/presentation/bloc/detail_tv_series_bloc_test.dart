
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import 'detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late DetailTvSeriesBloc tvseriesBloc;

  const tId = 1;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvseriesBloc = DetailTvSeriesBloc(mockGetTvSeriesDetail);
  });

  test('initial state should be empty', () {
    expect(tvseriesBloc.state, DetailTvSeriesEmpty());
  });

   blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'when data success emit loading and hasData state',
    build: () {
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async =>  Right(tTvSeriesDetail));
      return tvseriesBloc;
    },
    act: (blocAct) => blocAct.add(OnDetailTvSeriesEvent(tId)),
    expect: () => [
      DetailTvSeriesLoading(),
      DetailTvSeriesHasData(tTvSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(tId));
      return OnDetailTvSeriesEvent(tId).props;
    },
  );

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvseriesBloc;
    },
    act: (blocAct) => blocAct.add(OnDetailTvSeriesEvent(tId)),
    expect: () => [
      DetailTvSeriesLoading(),
      DetailTvSeriesError('Server Failure'),
    ],
    verify: (blocAct) => DetailTvSeriesLoading(),
  );
}