// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, constant_identifier_names

import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  const NowPlayingTvSeriesPage({super.key});
  static const ROUTE_NAME = '/now-playing-tv-series';

  @override
  _NowPlayingTvSeriesPageState createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context
          .read<NowPlayingTvSeriesBloc>()
          .add(OnNowPlayingTvSeriesEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
          builder: (context, state) {
            if (state is NowPlayingTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvSeriesHasData) {
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
            } else if (state is NowPlayingTvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Error Get Now Playing TV Series'),
              );
            }
          },
        ),
      ),
    );
  }
}
