import 'dart:convert';
import 'dart:io';

import 'package:rxddartexamples/model/Person.dart';
import 'package:rxddartexamples/model/animal.dart';
import 'package:rxddartexamples/model/thing.dart';

typedef SearchTerm = String;

class Api {
  List<Person>? _person;

  List<Animal>? _animal;

  Api();

  Future<List<Thing>?> search(SearchTerm searchterm) async {
    final term = searchterm.trim().toLowerCase();
    final cahedresults = _extractthinhgsusingsearchterm(term);
    if (cahedresults != null) {
      return cahedresults;
    }
    try {
      final persons =
          await _getjson("http://localhost:5500/lib/apis/persons.json")
              .then((json) => json.map((element) => Person.fromJson(element)));
      _person = persons.toList();
    } catch (e,stacktrace) {
      print(e);
      print(stacktrace);
    }
    try {
      final animal =
          await _getjson("http://localhost:5500/lib/apis/animal.json").then(
              (result) => result.map((element) => Animal.fromJson(element)));
      _animal = animal.toList();
    } catch (e) {
      print(e);
    }

    return _extractthinhgsusingsearchterm(term) ?? [];
  }

  List<Thing>? _extractthinhgsusingsearchterm(SearchTerm searchterm) {
    final cacheperson = _person;
    final cacheanimal = _animal;
    List<Thing>? result = [];
    if (cacheperson != null && cacheanimal != null) {
      for (final animal in cacheanimal) {
        if (animal.name.trimmedcontaines(searchterm) ||
            animal.animaltype.name.trimmedcontaines(searchterm)) {
          result.add(animal);
        }
      }
      for (final person in cacheperson) {
        if (person.age.toString().trimmedcontaines(searchterm) ||
            person.name.trimmedcontaines(searchterm)) {
          result.add(person);
        }
      }
      return result;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> _getjson(String url) => HttpClient()
      .getUrl(Uri.parse(url)) // Takes the url
      .then((req) => req.close()) // Takes the request
      .then((resposne) =>
          resposne.transform(utf8.decoder).join()) // Gives a response
      .then((jsonString) => json.decode(jsonString)
          as List<dynamic>); //Make the resposne List<dynamic>
}

extension Trimmedcasesensitive on String {
  bool trimmedcontaines(String other) =>
      trim().toLowerCase().contains(other.trim().toLowerCase());
}
