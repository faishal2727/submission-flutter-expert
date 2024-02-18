import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';
import '../../../dummy_data/tv_series/dummy_object.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MockGetWatchlistTvSeries getWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries getWatchlistTvSeriesStatus;
  late MockSaveWatchlistTvSeries saveTvSeriesWatchList;
  late MockRemoveWatchlistTvSeries removeTvSeriesWatchlist;
  late WatchlistTvSeriesBloc watchlistBloc;

  setUp(() {
    getWatchlistTvSeries = MockGetWatchlistTvSeries();
    getWatchlistTvSeriesStatus = MockGetWatchListStatusTvSeries();
    saveTvSeriesWatchList = MockSaveWatchlistTvSeries();
    removeTvSeriesWatchlist = MockRemoveWatchlistTvSeries();
    watchlistBloc = WatchlistTvSeriesBloc(
      getWatchlistTvSeries,
      getWatchlistTvSeriesStatus,
      removeTvSeriesWatchlist,
      saveTvSeriesWatchList,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, WatchlistTvSeriesInitial());
  });

  group(
    'this test for get watchlist tv series, ',
    () {
      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistTvSeries.execute())
              .thenAnswer((_) async => Right([tWatchlistTvSeries]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesHasData([tWatchlistTvSeries]),
        ],
        verify: (bloc) {
          verify(getWatchlistTvSeries.execute());
          return OnGethWatchlistTvSeries().props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistTvSeries.execute()).thenAnswer(
              (_) async =>  Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesError('Server Failure'),
        ],
        verify: (bloc) => WatchlistTvSeriesLoading(),
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistTvSeries.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesEmpty(),
        ],
      );
    },
  );

  group(
    'this test for get tv series watchlist status,',
    () {
      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should get true when the watchlist status is true',
        build: () {
          when(getWatchlistTvSeriesStatus.execute(tTvSeriesDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(FetchWatchTvSerieslistStatus(tTvSeriesDetail.id)),
        expect: () => [
          TvSeriesIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistTvSeriesStatus.execute(tTvSeriesDetail.id));
          return FetchWatchTvSerieslistStatus(tTvSeriesDetail.id).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should get false when the watchlist status is false',
        build: () {
          when(getWatchlistTvSeriesStatus.execute(tTvSeriesDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(FetchWatchTvSerieslistStatus(tTvSeriesDetail.id)),
        expect: () => [
          TvSeriesIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistTvSeriesStatus.execute(tTvSeriesDetail.id));
          return FetchWatchTvSerieslistStatus(tTvSeriesDetail.id).props;
        },
      );
    },
  );

  group(
    'this test for add and remove tv series watchlist,',
    () {
      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveTvSeriesWatchList.execute(tTvSeriesDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTvSeriesToWatchlist(tTvSeriesDetail)),
        expect: () => [
          WatchlistTvSeriesMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveTvSeriesWatchList.execute(tTvSeriesDetail));
          return AddTvSeriesToWatchlist(tTvSeriesDetail).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveTvSeriesWatchList.execute(tTvSeriesDetail)).thenAnswer(
              (_) async =>
                   Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTvSeriesToWatchlist(tTvSeriesDetail)),
        expect: () => [
          WatchlistTvSeriesError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveTvSeriesWatchList.execute(tTvSeriesDetail));
          return AddTvSeriesToWatchlist(tTvSeriesDetail).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeTvSeriesWatchlist.execute(tTvSeriesDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveTvSeriesFromWatchlist(tTvSeriesDetail)),
        expect: () => [
          WatchlistTvSeriesMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeTvSeriesWatchlist.execute(tTvSeriesDetail));
          return RemoveTvSeriesFromWatchlist(tTvSeriesDetail).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeTvSeriesWatchlist.execute(tTvSeriesDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('cannot add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveTvSeriesFromWatchlist(tTvSeriesDetail)),
        expect: () => [
          WatchlistTvSeriesError('cannot add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeTvSeriesWatchlist.execute(tTvSeriesDetail));
          return RemoveTvSeriesFromWatchlist(tTvSeriesDetail).props;
        },
      );
    },
  );
}
