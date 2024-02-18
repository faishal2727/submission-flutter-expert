// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, constant_identifier_names

import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class PopularTvSeriesPage extends StatefulWidget {
  const PopularTvSeriesPage({super.key});
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularTvSeriesBloc>().add(OnPopularTvSeriesEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
          key: const Key('popular tvseries'),
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesHasData) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final tvSeries = result[index];
                    return TvSeriesCard(tvSeries);
                  },
                  itemCount: result.length,
                ),
              );
            } else if (state is PopularTvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is PopularTvSeriesEmpty) {
              return const Center(
                key: Key('error_message'),
                child: Text('Empty'),
              );
            } else {
              return const Center(
                child: Text('Error Get Top Rated TV Series'),
              );
            }
          },
        ),
      ),
    );
  }
}
