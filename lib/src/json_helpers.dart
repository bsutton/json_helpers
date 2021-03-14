part of '../json_helpers.dart';

T fromJson<T>(json, T Function(Map<String, dynamic>) fromJson) {
  if (json is Map) {
    return fromJson(json.cast());
  } else {
    throw ArgumentError(
        'Argument \'json\' must be of type \'Map\': ${json.runtimeType}');
  }
}

extension ListExtension on List {
  List<T> json<T>(T Function(Map<String, dynamic>) fromJson) {
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      final element = this[i];
      if (element is Map) {
        final value = element.json(fromJson);
        result.add(value);
      } else {
        ArgumentError(
            'Element with index \'$i\' must be of type \'Map\': \'${element.runtimeType}\'');
      }
    }

    return result;
  }
}

extension MapExtension on Map {
  T json<T>(T Function(Map<String, dynamic>) fromJson) {
    return fromJson(cast());
  }
}

extension StringExtension on String {
  T json<T>(T Function(Map<String, dynamic>) fromJson) {
    final json = jsonDecode(this);
    if (json is Map) {
      return json.json(fromJson);
    }

    return throw ArgumentError(
        'The decoding result type is not a \'Map\': ${json.runtimeType}');
  }

  List<T> jsonList<T>(T Function(Map<String, dynamic>) fromJson) {
    final json = jsonDecode(this);
    if (json is List) {
      return json.json(fromJson);
    }

    return throw ArgumentError(
        'The decoding result type is not a \'List\': ${json.runtimeType}');
  }
}
