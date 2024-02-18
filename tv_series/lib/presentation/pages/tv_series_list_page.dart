// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'detail_tv_series_page.dart';
import 'now_playing_tv_series_page.dart';
import 'popular_tv_series_page.dart';
import 'top_rated_tv_series_page.dart';

class TvSeriesListPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-list';
  const TvSeriesListPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<NowPlayingTvSeriesBloc>().add(OnNowPlayingTvSeriesEvent());
        context.read<PopularTvSeriesBloc>().add(OnPopularTvSeriesEvent());
        context.read<TopRatedTvSeriesBloc>().add(OnTopRatedTvSeriesEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () {
                  Navigator.pushNamed(
                      context, NowPlayingTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
                builder: (context, state) {
                  if (state is NowPlayingTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvSeriesHasData) {
                    final result = state.result;
                    return TvSeriesList(result);
                  } else if (state is NowPlayingTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else if (state is NowPlayingTvSeriesEmpty) {
                    return const Center(
                      child: Text(
                        'empty',
                        key: Key('empty_message'),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Error Get Top Rated TV Series'),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, state) {
                  if (state is PopularTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvSeriesHasData) {
                    final result = state.result;

                    return TvSeriesList(result);
                  } else if (state is PopularTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else if (state is PopularTvSeriesEmpty) {
                    return const Center(
                      child: Text(
                        'empty',
                        key: Key('empty_message'),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Error Get Top Rated TV Series'),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvSeriesHasData) {
                    final result = state.result;
                    return TvSeriesList(result);
                  } else if (state is TopRatedTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else if (state is TopRatedTvSeriesEmpty) {
                    return const Center(
                      child: Text(
                        'empty',
                        key: Key('empty_message'),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Error Get Top Rated TV Series'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ),
    ],
  );
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailTvSeriesPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
