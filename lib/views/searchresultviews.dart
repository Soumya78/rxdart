import 'package:flutter/material.dart';
import 'package:rxddartexamples/bloc/searchresult.dart';
import 'package:rxddartexamples/model/Person.dart';

import '../model/animal.dart';

class Searchresultviews extends StatelessWidget {
  final Stream<Searchresult?> searchresdults;

  const Searchresultviews({super.key, required this.searchresdults});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: searchresdults,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data;

            if (result is Searchresulthaserror) {
              return const Text('Got error');
            } else if (result is SearchresultLoading) {
              return const CircularProgressIndicator();
            } else if (result is SearchNoresult) {
              return const Text("No resultfound with your searchterm");
            } else if (result is Searchresultwithresult) {
              final results = result.results;
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final items = results[index];
                    final String title;
                    if (items is Animal) {
                      title = 'Animal';
                    } else if (items is Person) {
                      title = 'Person';
                    } else {
                      title = "Unknown";
                    }
                    return ListTile(
                      title: Text(title),
                      subtitle: Text(items.toString()),
                    );
                  },
                  itemCount: results!.length,
                ),
              );
            }else{
              return Text('Unknown state');
            }
          } else {
            return const Text('No data');
          }
        });
  }
}
