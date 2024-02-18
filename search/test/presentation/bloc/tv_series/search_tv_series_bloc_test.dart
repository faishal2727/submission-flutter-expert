import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../../dummy_data/tv_series/dummy_object.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesBloc = SearchTvSeriesBloc(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchTvSeriesBloc.state, SearchTvSeriesEmpty());
  });

  final tSeriesList = <TvSeries>[tTvSeries];
  final tQuery = 'Hazbin Hotel';

  test('initial state should be empty', () {
    expect(searchTvSeriesBloc.state, SearchTvSeriesEmpty());
  });

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      return searchTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvSeriesChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesHasData(tSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvSeriesChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
