part of '../json_helpers.dart';

/// Converts argument `json` to object `T` using the converter function
/// `fromJson`
T fromJson<T>(json, T Function(Map<String, dynamic>) fromJson) {
  if (json is Map) {
    return fromJson(json.cast());
  } else {
    throw ArgumentError(
        'Argument \'json\' must be of type \'Map\': ${json.runtimeType}');
  }
}

extension ListExtension on List {
  /// Converts this list to `List<T>` using the converter function `fromJson`
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
  /// Converts this map to object `T` using the converter function `fromJson`
  T json<T>(T Function(Map<String, dynamic>) fromJson) {
    return fromJson(cast());
  }
}

extension StringExtension on String {
  /// Converts this string to object `T` using the converter function
  /// `fromJson`
  T json<T>(T Function(Map<String, dynamic>) fromJson) {
    final json = jsonDecode(this);
    if (json is Map) {
      return json.json(fromJson);
    }

    throw ArgumentError(
        'The decoding result type is not a \'Map\': ${json.runtimeType}');
  }

  /// Converts this string to `List<T>` using the converter function `fromJson`
  List<T> jsonList<T>(T Function(Map<String, dynamic>) fromJson) {
    final json = jsonDecode(this);
    if (json is List) {
      return json.json(fromJson);
    }

    throw ArgumentError(
        'The decoding result type is not a \'List\': ${json.runtimeType}');
  }

  /// Converts this string to `Map<String, T>` using the converter function
  /// `fromJson`
  Map<String, V> jsonMap<V>(V Function(Map<String, dynamic>) fromJson) {
    final json = jsonDecode(this);
    if (json is Map) {
      final result = <String, V>{};
      for (final key in json.keys) {
        if (key is String) {
          final value = json[key];
          if (value is Map) {
            final v = value.json(fromJson);
            result[key] = v;
          } else {
            throw ArgumentError(
                'The decoded value type with key \'$key\ is not a \'Map\': ${key.runtimeType}');
          }
        } else {
          throw ArgumentError(
              'The decoded key type is not a \'String\': ${key.runtimeType}');
        }
      }

      return result;
    }

    throw ArgumentError(
        'The decoding result type is not a \'Map\': ${json.runtimeType}');
  }
}
