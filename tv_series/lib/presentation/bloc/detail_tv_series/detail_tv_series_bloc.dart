// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetTvSeriesDetail _getDetailTvSeriess;

  DetailTvSeriesBloc(this._getDetailTvSeriess) : super(DetailTvSeriesEmpty()) {
    on<OnDetailTvSeriesEvent>(_onDetailTvSeriesEvent);
  }

  Future<void> _onDetailTvSeriesEvent(
      OnDetailTvSeriesEvent event, Emitter<DetailTvSeriesState> state) async {
    final id = event.id;
    emit(DetailTvSeriesLoading());

    final result = await _getDetailTvSeriess.execute(id);

    result.fold(
      (failure) {
        emit(DetailTvSeriesError(failure.message));
      },
      (detail) {
        emit(DetailTvSeriesHasData(detail));
      },
    );
  }
}
