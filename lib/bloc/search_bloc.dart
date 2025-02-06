import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart/rxdart.dart';
import 'package:rxddartexamples/bloc/searchresult.dart';

import 'api.dart';

@immutable
class Searchbloc {
  final Sink<String> search;

  final Stream<Searchresult?> searchresult;
  void dispose(){
    search.close();
  }

  const Searchbloc._({required this.search, required this.searchresult});

  factory Searchbloc ({required Api api}) {
    final  textchangers = BehaviorSubject<String>();
    final Stream<Searchresult?> results = textchangers
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap<Searchresult?>((String searchterm) {
      if (searchterm.isEmpty) {
        return Stream<Searchresult?>.value(null);
      } else {
       return Rx.fromCallable(() => api.search(searchterm))
            .delay(const Duration(seconds: 1))
            .map((result) => result!.isEmpty
                ? SearchNoresult()
                : Searchresultwithresult(result))
            .startWith(const SearchresultLoading())
            .onErrorReturnWith(
                (error, _) => Searchresulthaserror(error: error));
      }
    });
    return Searchbloc._(search: textchangers.sink, searchresult: results);
  }
}
