import 'package:flutter/foundation.dart' show immutable;
import 'package:rxddartexamples/model/thing.dart';

enum Animaltype { Dog, cat, Elephant, unknown }

@immutable
class Animal extends Thing {
  final Animaltype animaltype;

  const Animal({required String name, required this.animaltype})
      : super(name: name);

  @override
  String toString() => 'Animal,name: $name,type:$animaltype';

  factory Animal.fromJson(Map<String,dynamic>json){
    final Animaltype animaltype ;
    switch ((json["type"] as String).toLowerCase().trim()){
      case "cat":
        animaltype = Animaltype.cat ;
      case "dog":
        animaltype = Animaltype.Dog ;
      case "elephant":
        animaltype = Animaltype.Elephant;
      default:
        animaltype = Animaltype.unknown ;
    }
    return Animal(name: json["name"] as String, animaltype: animaltype);
  }
}
