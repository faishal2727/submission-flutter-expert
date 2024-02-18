// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries _getTopRatedTvSeriess;

  TopRatedTvSeriesBloc(this._getTopRatedTvSeriess)
      : super(TopRatedTvSeriesEmpty()) {
    on<OnTopRatedTvSeriesEvent>(_onTopRatedTvSeriesEvent);
  }

  Future<void> _onTopRatedTvSeriesEvent(OnTopRatedTvSeriesEvent event,
      Emitter<TopRatedTvSeriesState> state) async {
    emit(TopRatedTvSeriesLoading());

    final result = await _getTopRatedTvSeriess.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvSeriesError(failure.message));
      },
      (toRated) {
        if (toRated.isEmpty) {
          emit(TopRatedTvSeriesEmpty());
        } else {
          emit(TopRatedTvSeriesHasData(toRated));
        }
      },
    );
  }
}
