// ignore_for_file: override_on_non_overriding_member

part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {}

class PopularTvSeriesLoading extends PopularTvSeriesState {
  @override
  List<Object> get props => [];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvSeriesHasData extends PopularTvSeriesState {
  final List<TvSeries> result;

  PopularTvSeriesHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class PopularTvSeriesEmpty extends PopularTvSeriesState {
  @override
  List<Object> get props => [];
}
