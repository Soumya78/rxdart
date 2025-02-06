import 'package:flutter/foundation.dart' show immutable;

import '../model/thing.dart';

@immutable
abstract class Searchresult{
  const Searchresult();
}

@immutable
class SearchresultLoading implements Searchresult{
const SearchresultLoading();
}
@immutable
class SearchNoresult implements Searchresult{
  const SearchNoresult();
}
@immutable
class Searchresulthaserror implements Searchresult{
final Object error ;

  const Searchresulthaserror({required this.error});
}
@immutable
class Searchresultwithresult implements Searchresult{
  final List<Thing>? results ;
Searchresultwithresult(this.results);
}