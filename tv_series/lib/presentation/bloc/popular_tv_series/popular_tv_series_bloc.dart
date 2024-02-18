// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _getPopularTvSeriess;

  PopularTvSeriesBloc(this._getPopularTvSeriess)
      : super(PopularTvSeriesEmpty()) {
    on<OnPopularTvSeriesEvent>(_onPopularTvSeriesEvent);
  }

  Future<void> _onPopularTvSeriesEvent(
      OnPopularTvSeriesEvent event, Emitter<PopularTvSeriesState> state) async {
    emit(PopularTvSeriesLoading());

    final result = await _getPopularTvSeriess.execute();

    result.fold(
      (failure) {
        emit(PopularTvSeriesError(failure.message));
      },
      (popular) {
        if (popular.isEmpty) {
          emit(PopularTvSeriesEmpty());
        } else {
          emit(PopularTvSeriesHasData(popular));
        }
      },
    );
  }
}