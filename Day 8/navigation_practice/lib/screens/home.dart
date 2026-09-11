import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  String _lastResult = '';

  Future<void> _openDetails() async {
    final result = await Navigator.of(context).pushNamed('/details', arguments: 'Razi');
    if (result != null) setState(() => _lastResult = result as String);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: const [Tab(text: 'All'), Tab(text: 'Favorites'), Tab(text: 'Recent')],
            indicator: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.amber, width: 4)),
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                Center(child: Text('All items')),
                Center(child: Text('Favorite items')),
                Center(child: Text('Recent items')),
              ],
            ),
          ),
          ElevatedButton(onPressed: _openDetails, child: const Text('Go to Details')),
          if (_lastResult.isNotEmpty) Text('Last result: $_lastResult'),
        ],
      ),
    );
  }
}