import 'package:test_project/helpers/date_helper.dart';
import 'package:test_project/services/localstorage.dart';

import 'child.dart';

/// Модель сотрудника
class Employee {
  final String lastName;
  final String firstName;
  final String surName;
  final DateTime dateOfBirth;
  final String position;
  final List<Child>? children;
  const Employee(
      {required this.lastName,
      required this.firstName,
      required this.surName,
      required this.dateOfBirth,
      required this.position,
      this.children});
  static final String listLocalStorageKey = 'employeeList';
  bool get hasChildren => (children?.length ?? 0) > 0;
  String get fullName => "$lastName $firstName $surName";

  /// Пустой `Employee`
  factory Employee.empty() {
    return Employee(
        lastName: '',
        firstName: '',
        surName: '',
        dateOfBirth: DateTime.fromMillisecondsSinceEpoch(0),
        position: '');
  }
  factory Employee.addFirstChild(Employee employee, Child child) => Employee(
      lastName: employee.lastName,
      firstName: employee.firstName,
      surName: employee.surName,
      dateOfBirth: employee.dateOfBirth,
      position: employee.position,
      children: [child]);

  /// Экземплеяр класса `Employee` получаемый из json
  factory Employee.fromJson(Map<String, dynamic>? json) {
    if (json != null)
      return Employee(
          firstName: json[r'firstName'] ?? '',
          lastName: json[r'lastName'] ?? '',
          surName: json[r'surName'] ?? '',
          position: json[r'position'] ?? '',
          dateOfBirth: json[r'dateOfBirth'] == null
              ? DateTime.fromMillisecondsSinceEpoch(0)
              : DateTime.parse(json[r'dateOfBirth']),
          children: Child.listFromJson(json[r'children']));
    return Employee.empty();
  }

  ///
  static List<Employee>? fromLocalStorage() {
    var json = localstorage.getItem(listLocalStorageKey);
    return Employee.listFromJson(json);
  }

  static List<Employee>? listFromJson(
    List<dynamic>? json, {
    bool? emptyIsNull,
    bool? growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <Employee>[]
          : json
              .map((v) => Employee.fromJson(v))
              .toList(growable: true == growable);

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map[r'firstName'] = firstName;
    map[r'lastName'] = lastName;
    map[r'surName'] = surName;
    map[r'position'] = position;
    map[r'dateOfBirth'] = DateCoder.encode(dateOfBirth);
    map[r'children'] =
        children?.map((e) => e.toJson()) ?? Map<String, dynamic>();
    return map;
  }

  static Future<void> saveToLocalStorage(List<Employee> employeeList) async {
    await localstorage.setItem(listLocalStorageKey, employeeList);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Employee &&
          other.lastName == lastName &&
          other.firstName == firstName &&
          other.surName == surName &&
          other.dateOfBirth == dateOfBirth &&
          other.position == position;
  @override
  String toString() {
    return "Employee $lastName $firstName $surName $dateOfBirth $position $children";
  }

  @override
  int get hashCode =>
      lastName.hashCode +
      firstName.hashCode +
      surName.hashCode +
      dateOfBirth.hashCode +
      position.hashCode;
}
