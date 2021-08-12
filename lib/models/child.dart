import 'package:test_project/helpers/date_helper.dart';

/// Модель ребёнка
class Child {
  final String lastName;
  final String firstName;
  final String surName;
  final DateTime dateOfBirth;

  const Child({
    required this.lastName,
    required this.firstName,
    required this.surName,
    required this.dateOfBirth,
  });
  String get fullName => "$lastName $firstName $surName";

  factory Child.empty() {
    return Child(
      lastName: '',
      firstName: '',
      surName: '',
      dateOfBirth: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
  factory Child.fromJson(Map<String, dynamic>? json) {
    if (json != null)
      return Child(
        firstName: json[r'firstName'] ?? '',
        lastName: json[r'lastName'] ?? '',
        surName: json[r'surName'] ?? '',
        dateOfBirth: json[r'dateOfBirth'] == null
            ? DateTime.fromMillisecondsSinceEpoch(0)
            : DateTime.parse(json[r'dateOfBirth']),
      );
    return Child.empty();
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map[r'firstName'] = firstName;
    map[r'lastName'] = lastName;
    map[r'surName'] = surName;
    map[r'dateOfBirth'] = DateCoder.encode(dateOfBirth);
    return map;
  }

  static List<Child>? listFromJson(
    List<dynamic>? json, {
    bool? emptyIsNull,
    bool? growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <Child>[]
          : json
              .map((v) => Child.fromJson(v))
              .toList(growable: true == growable);
}
