
// ignore_for_file: prefer_const_constructors_in_immutables

part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();
  @override
  List<Object> get props => [];

}

class DetailTvSeriesLoading extends DetailTvSeriesState {
  @override
  List<Object> get props => [];
}

class DetailTvSeriesError extends DetailTvSeriesState {
  final String message;

  DetailTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvSeriesHasData extends DetailTvSeriesState {
  final TvSeriesDetail result;

  DetailTvSeriesHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class DetailTvSeriesEmpty extends DetailTvSeriesState {
  @override
  List<Object> get props => [];
}
