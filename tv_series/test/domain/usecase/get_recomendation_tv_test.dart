import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recomendations.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvRepository);
  });

  final tId = 1;
  final tTvs = <TvSeries>[];

  test('should get list of Tv recommendations from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvs));
  });
}
