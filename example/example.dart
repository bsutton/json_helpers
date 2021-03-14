import 'package:json_helpers/json_helpers.dart';

void main() {
  List list;
  Map map;
  String string;

  // String to Person
  string = '{"name": "Jack"}';
  var person = string.json((e) => Person.fromJson(e));
  assert(person.name == 'Jack');

  // String to List<Person>
  string = '[{"name": "Jack"}, {"name": "John"}]';
  var personList = string.jsonList((e) => Person.fromJson(e));
  assert(personList[1].name == 'John');

  // Map to Person
  map = {'name': 'Jack'};
  person = map.json((e) => Person.fromJson(e));
  assert(person.name == 'Jack');

  // Map to Person
  person = fromJson(map, (e) => Person.fromJson(e));
  assert(person.name == 'Jack');

  // List<Map> to List<Person>
  list = [
    {'name': 'Jack'},
    {'name': 'John'}
  ];
  personList = list.json((e) => Person.fromJson(e));
  assert(personList[1].name == 'John');
}

class Person {
  final String name;

  Person({required this.name});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(name: (json['name'] as String?) ?? '');
  }

  Map<String, dynamic> toJson() => {'name': name};
}
