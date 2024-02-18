// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, constant_identifier_names
import 'package:flutter/material.dart';
import 'movie/watchlist_movies_page.dart';
import 'tv_series/watchlist_tv_series_page.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watclis-paget';
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _listTabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  final List<Widget> _listTabs = [
    const Text('Movies'),
    const Text('TV Series'),
  ];

  final List<Widget> _listWidget = [
    WatchlistMoviesPage(),
    WatchlistTvSeriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(16),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: _listTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _listWidget,
      ),
    );
  }
}
