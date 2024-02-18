
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailMovieBloc movieBloc;
  const tId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  test('initial state empty', () {
    expect(movieBloc.state, DetailMovieEmpty());
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'when data success emit loading and hasData state',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async =>  Right(testMovieDetail));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(OnDetailMovieEvent(tId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
      return OnDetailMovieEvent(tId).props;
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'when data unsuccess emitting loading or error state',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnDetailMovieEvent(tId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieError('Server Failure'),
    ],
    verify: (bloc) => DetailMovieLoading(),
  );
}