// ignore_for_file: override_on_non_overriding_member

part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesState extends Equatable {}

class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  final String message;

  NowPlayingTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvSeriesHasData extends NowPlayingTvSeriesState {
  final List<TvSeries> result;

  NowPlayingTvSeriesHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class NowPlayingTvSeriesEmpty extends NowPlayingTvSeriesState {
  @override
  List<Object> get props => [];
}
