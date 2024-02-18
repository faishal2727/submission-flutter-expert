// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides

import 'package:core/core.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          context.read<WatchlistTvSeriesBloc>().add(OnGethWatchlistTvSeries()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
     context.read<WatchlistTvSeriesBloc>().add(OnGethWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
      child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        builder: (context, state) {
          if (state is WatchlistTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return TvSeriesCard(movie);
              },
              itemCount: state.result.length,
            );
          } else if (state is WatchlistTvSeriesEmpty) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.visibility_off, size: 72),
                    const SizedBox(height: 2),
                    Text('Empty Watchlist', style: kSubtitle),
                  ],
                ),
              );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('error'),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
