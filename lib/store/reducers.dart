import 'package:redux/redux.dart';
import 'package:test_project/models/employee.dart';
import 'package:test_project/store/actions.dart';

/// Функции-обработчики для сохранения состояния приложения
final employeeListReducer = combineReducers<List<Employee>?>([
  TypedReducer<List<Employee>?, SetEmployees>(_setEmployees),
  TypedReducer<List<Employee>?, AddEmployee>(_addEmployee),
  TypedReducer<List<Employee>?, UpdateEmployee>(_updateEmployee)
]);

List<Employee>? _setEmployees(List<Employee>? state, SetEmployees action) {
  return action.employees;
}

List<Employee> _addEmployee(List<Employee>? state, AddEmployee action) {
  var employees = state?.toList() ?? List.empty(growable: true);
  employees.add(action.employee);
  print(employees);
  return employees;
}

List<Employee> _updateEmployee(List<Employee>? state, UpdateEmployee action) {
  var employees = state?.toList() ?? List.empty(growable: true);
  if (employees.isNotEmpty) {
    var idx = employees.indexWhere((element) => element == action.employee);
    if (idx != -1)
      employees[idx] = action.employee;
    else
      employees.add(action.employee);
  } else
    employees.add(action.employee);
  return employees;
}
