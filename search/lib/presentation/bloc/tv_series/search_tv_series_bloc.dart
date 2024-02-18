import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<OnQueryTvSeriesChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvSeriesLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvSeriesError(failure.message));
        },
        (data) {
          emit(SearchTvSeriesHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}


