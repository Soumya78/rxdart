import 'package:flutter/material.dart';
import 'package:rxddartexamples/bloc/api.dart';
import 'package:rxddartexamples/bloc/search_bloc.dart';
import 'package:rxddartexamples/views/searchresultviews.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final Searchbloc _searchbloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchbloc = Searchbloc(api: Api());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchbloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration:
                  const InputDecoration(hintText: 'Enter your search term'),
              onChanged: _searchbloc.search.add,
            ),
            const SizedBox(
              height: 10,
            ),
            Searchresultviews(searchresdults: _searchbloc.searchresult)
          ],
        ),
      ),
    );
  }
}
