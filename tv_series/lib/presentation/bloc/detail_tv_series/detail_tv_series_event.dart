part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {}

class OnDetailTvSeriesEvent extends DetailTvSeriesEvent {
  final int id;

  OnDetailTvSeriesEvent(this.id);

  @override
  List<Object> get props => [id];
}
