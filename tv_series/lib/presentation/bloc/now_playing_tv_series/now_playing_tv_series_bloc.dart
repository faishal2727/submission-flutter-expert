// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeriess;

  NowPlayingTvSeriesBloc(this._getNowPlayingTvSeriess)
      : super(NowPlayingTvSeriesEmpty()) {
    on<OnNowPlayingTvSeriesEvent>(_onNowPlayingTvSeriesEvent);
  }

  Future<void> _onNowPlayingTvSeriesEvent(
      OnNowPlayingTvSeriesEvent event, Emitter<NowPlayingTvSeriesState> state) async {
    emit(NowPlayingTvSeriesLoading());

    final result = await _getNowPlayingTvSeriess.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTvSeriesError(failure.message));
      },
      (nowPlaying) {
        if (nowPlaying.isEmpty) {
          emit(NowPlayingTvSeriesEmpty());
        } else {
          emit(NowPlayingTvSeriesHasData(nowPlaying));
        }
      },
    );
  }
}
