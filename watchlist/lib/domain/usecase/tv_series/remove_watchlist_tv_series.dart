import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTvSeries {
  final TvSeriesRepository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchlist(tvSeries);
  }
}