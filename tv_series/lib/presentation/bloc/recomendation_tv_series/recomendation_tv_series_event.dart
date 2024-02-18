part of 'recomendation_tv_series_bloc.dart';

abstract class RecomendationTvSeriesEvent extends Equatable {}

class OnRecomendationTvSeriesEvent extends RecomendationTvSeriesEvent {
  final int id;

  OnRecomendationTvSeriesEvent(this.id);

  @override
  List<Object> get props => [id];
}
