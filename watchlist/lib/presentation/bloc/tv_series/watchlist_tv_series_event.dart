part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {}

class OnGethWatchlistTvSeries extends WatchlistTvSeriesEvent {
  @override
  List<Object> get props => [];
}

class FetchWatchTvSerieslistStatus extends WatchlistTvSeriesEvent {
  final int id;

  FetchWatchTvSerieslistStatus(this.id);

  @override
  List<Object> get props => [id];
}
class AddTvSeriesToWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeries;

  AddTvSeriesToWatchlist(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class RemoveTvSeriesFromWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeries;

  RemoveTvSeriesFromWatchlist(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}