// ignore_for_file: prefer_const_constructors_in_immutables

part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTvSeriesChanged extends SearchTvSeriesEvent {
  final String query;
  OnQueryTvSeriesChanged(this.query);

  @override
  List<Object> get props => [query];
}
