import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTvSeries _getWatchlistTvSeriess;
  final GetWatchListStatusTvSeries _getWatchlistStatus;
  final RemoveWatchlistTvSeries _removeWatchlist;
  final SaveWatchlistTvSeries _saveWatchlist;

  WatchlistTvSeriesBloc(
    this._getWatchlistTvSeriess,
    this._getWatchlistStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(WatchlistTvSeriesInitial()) {
    on<OnGethWatchlistTvSeries>(_onFetchTvSeriesWatchlist);
    on<FetchWatchTvSerieslistStatus>(_fetchWatchlistStatus);
    on<AddTvSeriesToWatchlist>(_addTvSeriesToWatchlist);
    on<RemoveTvSeriesFromWatchlist>(_removeTvSeriesFromWatchlist);
  }

  Future<void> _onFetchTvSeriesWatchlist(
    OnGethWatchlistTvSeries event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    emit(WatchlistTvSeriesLoading());

    final result = await _getWatchlistTvSeriess.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvSeriesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(WatchlistTvSeriesEmpty())
            : emit(WatchlistTvSeriesHasData(data));
      },
    );
  }

  Future<void> _fetchWatchlistStatus(
    FetchWatchTvSerieslistStatus event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistStatus.execute(id);

    emit(TvSeriesIsAddedToWatchlist(result));
  }

  Future<void> _addTvSeriesToWatchlist(
    AddTvSeriesToWatchlist event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    final tvSeries = event.tvSeries;

    final result = await _saveWatchlist.execute(tvSeries);

    result.fold(
      (failure) {
        emit(WatchlistTvSeriesError(failure.message));
      },
      (message) {
        emit(WatchlistTvSeriesMessage(message));
      },
    );
  }

  Future<void> _removeTvSeriesFromWatchlist(
    RemoveTvSeriesFromWatchlist event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    final tvSeries = event.tvSeries;

    final result = await _removeWatchlist.execute(tvSeries);

    result.fold(
      (failure) {
        emit(WatchlistTvSeriesError(failure.message));
      },
      (message) {
        emit(WatchlistTvSeriesMessage(message));
      },
    );
  }
}