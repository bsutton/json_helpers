import 'dart:convert';

import 'package:json_helpers/json_helpers.dart';
import 'package:test/test.dart';

void main() {
  final data1 = Data(name: 'test1');
  final data2 = Data(name: 'test2');
  final dataList = [data1, data2];
  final dataMapList = [data1.toJson(), data2.toJson()];
  final data1AsString = jsonEncode(data1);
  Map data1AsMap = data1.toJson();
  Map data2AsMap = data2.toJson();
  final dataListAsString = jsonEncode(dataList);
  test('String.json', () {
    final result = data1AsString.json((e) => Data.fromJson(e));
    expect(result, data1);
  });

  test('String.jsonMap', () {
    final string = '{"key1": {"name": "test1"}, "key2": {"name": "test2"}}';
    final result = string.jsonMap((e) => Data.fromJson(e));
    final matcher = {'key1': data1, 'key2': data2};
    expect(result, matcher);
  });

  test('String.jsonList', () {
    final result = dataListAsString.jsonList((e) => Data.fromJson(e));
    expect(result, dataList);
  });

  test('Map.json', () {
    final result = data1AsMap.json((e) => Data.fromJson(e));
    expect(result, data1);
  });

  test('List.json', () {
    final result = dataMapList.json((e) => Data.fromJson(e));
    expect(result, dataList);
  });

  test('List of list', () {
    final list = [
      [data1AsMap, data2AsMap],
      [data1AsMap, data2AsMap],
    ];

    final matcher = [
      [data1, data2],
      [data1, data2],
    ];

    final result =
        list.map((List e) => e.json((Map e) => Data.fromJson(e.cast())));
    expect(result, matcher);
  });
}

class Data {
  final String name;

  Data({required this.name});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(name: (json['name'] as String?) ?? '');
  }

  @override
  bool operator ==(other) {
    if (other is Data) {
      return name == other.name;
    }

    return false;
  }

  Map<String, dynamic> toJson() => {'name': name};
}
