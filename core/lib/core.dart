library core;

export 'styles/colors.dart';
export 'styles/text_styles.dart';
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/utils.dart';
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';
export 'data/models/movie_model.dart';
export 'data/models/movie_detail_model.dart';
export 'data/models/movie_response.dart';

export 'data/repositories/movie_repository_impl.dart';
export 'data/datasources/movie/movie_remote_data_source.dart';
export 'data/datasources/movie/movie_local_data_source.dart';
export 'domain/repositories/movie_repository.dart';

export 'data/repositories/tv_series_repository_impl.dart';
export 'data/datasources/tv_series/tv_series_remote_data_source.dart';
export 'data/datasources/tv_series/tv_series_local_data_source.dart';
export 'domain/repositories/tv_series_repository.dart';

export 'data/datasources/db/database_helper.dart';

