// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:core/domain/entities/tv_series.dart';

part 'recomendation_tv_series_event.dart';
part 'recomendation_tv_series_state.dart';

class RecomendationTvSeriesBloc
    extends Bloc<RecomendationTvSeriesEvent, RecomendationTvSeriesState> {
  final GetTvSeriesRecommendations _getRecomendationTvSeriess;

  RecomendationTvSeriesBloc(this._getRecomendationTvSeriess)
      : super(RecomendationTvSeriesEmpty()) {
    on<OnRecomendationTvSeriesEvent>(_onRecomendationTvSeriesEvent);
  }

  Future<void> _onRecomendationTvSeriesEvent(OnRecomendationTvSeriesEvent event,
      Emitter<RecomendationTvSeriesState> state) async {
    final id = event.id;
    emit(RecomendationTvSeriesLoading());

    final result = await _getRecomendationTvSeriess.execute(id);

    result.fold(
      (failure) {
        emit(RecomendationTvSeriesError(failure.message));
      },
      (recomendation) {
        if (recomendation.isEmpty) {
          emit(RecomendationTvSeriesEmpty());
        } else {
          emit(RecomendationTvSeriesHasData(recomendation));
        }
      },
    );
  }
}
